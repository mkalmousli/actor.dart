import 'dart:async';
import 'dart:io';

import 'package:aktor/src/models/aktor.dart';
import 'package:aktor/src/models/dart_file.dart';
import 'package:aktor/src/models/mode.dart';
import 'package:aktor/src/aktor_runner/bloc.dart' as b_aktor_runner;
import 'package:aktor/src/aktor_runner/state.dart' as s_aktor_runner;
import 'package:aktor/src/asset_reader.dart';
import 'package:aktor/src/ext.dart';
import 'package:aktor/version.dart';
import 'package:ansi/ansi.dart';
import 'package:collection/collection.dart';
import 'package:path/path.dart' as p;

/// Runs the aktor CLI with the given command-line arguments.
Future<int> runCli(List<String> args) async {
  final devFlags = {"-d", "--dev"};

  final actionsArgs = args
      .where((arg) => arg.startsWith("-") || arg.startsWith("--"))
      .toList();
  final pathArgs = args.where((arg) => !actionsArgs.contains(arg)).toList();

  if (actionsArgs.contains("-v") || actionsArgs.contains("--version")) {
    stdout.writeln(green("You are using aktor version $version."));
    return 0;
  }

  final Mode mode;
  if (devFlags.any(actionsArgs.contains)) {
    mode = Mode.dev;
  } else {
    mode = Mode.prod;
  }

  stdout.w(white("aktor v$version | "));
  stdout.w(cyan("${mode.name} mode"));
  stdout.nl();

  final dCurrent = Directory.current;

  /// Determines the input (either a file or directory) to process.
  final FileSystemEntity input;
  if (pathArgs.isEmpty) {
    input = dCurrent;
  } else {
    final pathArg = pathArgs.first;
    final entity = FileSystemEntity.typeSync(pathArg);
    if (entity == FileSystemEntityType.file) {
      input = File(pathArg);
    } else if (entity == FileSystemEntityType.directory) {
      input = Directory(pathArg);
    } else if (entity == FileSystemEntityType.notFound) {
      // Try to determine if it's meant to be a file or directory
      // If it ends with .dart, treat as file; otherwise, treat as directory
      if (pathArg.endsWith(".dart")) {
        input = File(pathArg);
      } else {
        input = Directory(pathArg);
      }
    } else {
      // Fallback to directory
      input = Directory(pathArg);
    }
  }

  stdout.l(grey("in: ${input.path}"));

  /// Get the starting directory from the input for root detection.
  final Directory dStart;
  if (input is Directory) {
    dStart = input;
  } else {
    dStart = input.parent;
  }

  final Directory dRoot = await () async {
    Directory dir = dStart;

    while (true) {
      if (await dir.f("pubspec.yaml").exists()) {
        return dir;
      }

      final parent = dir.parent;
      // Stop if we've reached the filesystem root (parent path equals current path)
      if (parent.path == dir.path) break;
      dir = parent;
      dir = await dir.resolveSymbolicLinks().then((v) => v.dir);
    }

    throw Exception("Couldn't find root package folder!");
  }();

  stdout.l(grey("root: ${dRoot.path}"));

  /// Recursively scans for Dart files, ignoring build directories.
  Stream<File> getInputFiles(Directory dir) async* {
    await for (final entity in dir.list()) {
      if (entity is File) {
        if (entity.name.endsWith(".dart")) {
          yield entity;
        }
      } else if (entity is Directory) {
        final isExcluded = [
          ".dart_tool",
          ".dyn",
          "build",
        ].any((name) => entity.name == name);
        if (isExcluded) continue;

        yield* getInputFiles(entity);
      }
    }
  }

  /// Gets all Dart files from a file system entity (file or directory).
  Stream<File> getDartFilesFromEntity(FileSystemEntity entity) async* {
    if (entity is File) {
      if (entity.path.endsWith(".dart") && await entity.exists()) {
        yield entity;
      }
    } else if (entity is Directory) {
      if (await entity.exists()) {
        yield* getInputFiles(entity);
      }
    }
  }

  final allDartFiles = <DartFile>{};
  final aktorRunners = <b_aktor_runner.AktorRunner>{};

  // Track live aktor dependencies: runner -> set of dependency file paths
  final liveAktorDependencies = <b_aktor_runner.AktorRunner, Set<String>>{};
  // Track which files are watched and by which runners
  final fileWatchers = <String, StreamSubscription>{};
  // Track runners watching each file
  final fileWatcherRunners = <String, Set<b_aktor_runner.AktorRunner>>{};
  // Track pending restarts to debounce rapid file changes
  final pendingRestarts = <b_aktor_runner.AktorRunner, Timer>{};
  final assetReader = AssetReader();

  // Forward declare the restart function
  late Future<void> Function(b_aktor_runner.AktorRunner) restartLiveAktor;

  /// Sets up file watching for a live aktor's dependencies.
  Future<void> setupLiveAktorWatching(
    b_aktor_runner.AktorRunner runner,
    DartFile dartFile,
  ) async {
    try {
      final dependencies = await dartFile.getDependencies(assetReader);
      liveAktorDependencies[runner] = dependencies;

      // For each dependency, set up a watcher if not already watching
      for (final depPath in dependencies) {
        // Initialize the set if it doesn't exist
        fileWatcherRunners.putIfAbsent(
          depPath,
          () => <b_aktor_runner.AktorRunner>{},
        );

        if (!fileWatchers.containsKey(depPath)) {
          final file = File(depPath);
          if (await file.exists()) {
            final depDir = file.parent;
            final normalizedDepPath = p.normalize(
              file.resolveSymbolicLinksSync(),
            );

            final watcher = depDir.watch().listen((event) async {
              try {
                // Only process modify and delete events (ignore create/resize)
                if (event.type != FileSystemEvent.modify &&
                    event.type != FileSystemEvent.delete) {
                  return;
                }

                // Normalize the event path for comparison
                final eventPath = event.path;
                final normalizedEventPath = p.normalize(
                  await File(eventPath).resolveSymbolicLinks(),
                );

                // Check if the changed file is the dependency
                if (normalizedEventPath == normalizedDepPath) {
                  // Restart all live aktors watching this file (with debouncing)
                  final runnersToRestart =
                      fileWatcherRunners[depPath]?.toList() ?? [];
                  for (final runnerToRestart in runnersToRestart) {
                    // Cancel any pending restart for this runner
                    pendingRestarts[runnerToRestart]?.cancel();

                    // Debounce: wait 200ms before restarting
                    // Only log on first detection, not on every event
                    // final changedFileRel = p.relative(
                    //   depPath,
                    //   from: dRoot.path,
                    // );
                    // final aktorPrefix =
                    //     "${p.relative(runnerToRestart.dartFile.file.path, from: dRoot.path)}:${runnerToRestart.aktor.lineNumber}:${runnerToRestart.aktor.columnNumber} #${runnerToRestart.aktor.functionName}";

                    // // Only log if this is a new pending restart (not a cancellation and re-creation)
                    // if (!hadPending) {
                    //   stdout.writeln(
                    //     yellow(
                    //       "File changed: $changedFileRel → reloading $aktorPrefix",
                    //     ),
                    //   );
                    // }

                    final timer = Timer(
                      const Duration(milliseconds: 200),
                      () async {
                        pendingRestarts.remove(runnerToRestart);
                        await restartLiveAktor(runnerToRestart);
                      },
                    );
                    pendingRestarts[runnerToRestart] = timer;
                  }
                }
              } catch (_) {
                // Ignore errors during path resolution
              }
            });
            fileWatchers[depPath] = watcher;
          }
        }

        // Add this runner to the list of runners watching this file
        fileWatcherRunners[depPath]!.add(runner);
      }
    } catch (_) {
      // If dependency resolution fails, skip watching for this aktor
    }
  }

  /// Restarts a live aktor by stopping and starting it again.
  restartLiveAktor = (b_aktor_runner.AktorRunner runner) async {
    // Check if runner still exists (might have been removed)
    if (!aktorRunners.contains(runner)) return;

    final aktor = runner.aktor;
    final dartFile = runner.dartFile;

    // Check current state - restart if running, completed, or failed
    // (but not if stopped, starting, or initial - those are transient states)
    final currentState = runner.state;
    final shouldRestart = currentState.maybeWhen(
      running: (_, _) => true,
      completed: (_, _) => true, // Restart completed live aktors
      failed: (_, _) => true, // Restart failed live aktors
      orElse: () => false,
    );

    if (!shouldRestart) return;

    // Cancel any pending restart for this runner
    pendingRestarts[runner]?.cancel();
    pendingRestarts.remove(runner);

    // Log reload start
    // stdout.writeln(magenta("% ${aktor.functionName}"));

    // Save the dependencies before stopping (we'll need to clean them up)
    final oldDependencies = liveAktorDependencies[runner]?.toSet() ?? {};

    // Stop the current runner (if it's running, otherwise just clean up)
    final wasRunning = currentState.maybeWhen(
      running: (_, _) => true,
      orElse: () => false,
    );

    if (wasRunning) {
      await runner.stop();
    } else {
      // For completed/failed runners, just close the bloc
      await runner.close();
    }

    // Clean up watcher references for old runner
    liveAktorDependencies.remove(runner);
    for (final depPath in oldDependencies) {
      fileWatcherRunners[depPath]?.remove(runner);
    }

    // Remove old runner from the list
    aktorRunners.remove(runner);

    // Small delay to ensure cleanup
    if (wasRunning) {
      await Future.delayed(const Duration(milliseconds: 100));
    }

    // Recreate and restart
    final newRunner = b_aktor_runner.AktorRunner(
      aktor: aktor,
      dartFile: dartFile,
      dRoot: dRoot,
      initialState: s_aktor_runner.State.initial(),
      isReload: true,
    );

    aktorRunners.add(newRunner);

    await newRunner.start(mode);

    // Re-setup watching if in dev mode and aktor is live
    if (aktor.isLive && mode == Mode.dev) {
      await setupLiveAktorWatching(newRunner, dartFile);
    }
  };

  /// Creates and starts a runner for the given aktor.
  Future<void> runAktor(Aktor aktor, DartFile dartFile) async {
    final runner = b_aktor_runner.AktorRunner(
      aktor: aktor,
      dartFile: dartFile,
      dRoot: dRoot,
      initialState: s_aktor_runner.State.initial(),
    );
    aktorRunners.add(runner);
    await runner.start(mode);

    // If aktor is live and we're in dev mode, set up dependency watching
    if (aktor.isLive && mode == Mode.dev) {
      await setupLiveAktorWatching(runner, dartFile);
    }
  }

  /// Processes a Dart file, managing aktors as they're added or removed.
  Future<void> processDartFile(DartFile dartFile) async {
    final oldDartFile = allDartFiles.firstWhereOrNull(
      (df) => df.file.path == dartFile.file.path,
    );
    allDartFiles.remove(oldDartFile);

    final isNew = oldDartFile == null;

    final newAktors = <Aktor>{};
    final removedAktors = <Aktor>{};

    if (isNew) {
      newAktors.addAll(dartFile.aktors);
    } else {
      newAktors.addAll(
        dartFile.aktors.where((a) => !oldDartFile.aktors.any((oa) => oa == a)),
      );
      removedAktors.addAll(
        oldDartFile.aktors.where((a) => !dartFile.aktors.any((oa) => oa == a)),
      );
    }

    for (final aktor in newAktors) {
      await runAktor(aktor, dartFile);
    }

    for (final aktor in removedAktors) {
      final runner = aktorRunners.firstWhereOrNull(
        (r) =>
            r.aktor.functionName == aktor.functionName &&
            r.dartFile.file.path == dartFile.file.path &&
            r.dRoot.path == dRoot.path,
      );
      if (runner != null) {
        // Cancel any pending restart
        pendingRestarts[runner]?.cancel();
        pendingRestarts.remove(runner);

        // Clean up watchers if it was a live aktor
        liveAktorDependencies.remove(runner);
        for (final runners in fileWatcherRunners.values) {
          runners.remove(runner);
        }
        await runner.stop();
        aktorRunners.remove(runner);
      }
    }

    allDartFiles.add(dartFile);
  }

  int iCycle = 0;

  /// Processes all Dart files from the input (file or directory).
  Future<void> processFiles() async {
    iCycle += 1;
    final isFirstCycle = iCycle == 1;

    if (aktorRunners.isEmpty) {
      // stdout.writeln(yellow("Searching for aktors..."));
    }

    // Clear asset reader cache to ensure fresh reads
    assetReader.clearCache();

    await for (final file in getDartFilesFromEntity(input)) {
      DartFile? dartFile;
      try {
        dartFile = await DartFile.parse(file, assetReader);
      } catch (_) {}

      if (dartFile == null) continue;
      await processDartFile(dartFile);
    }

    if (isFirstCycle && aktorRunners.isEmpty) {
      stdout.writeln(yellow("No aktors found."));
    }
  }

  await processFiles();

  if (mode == Mode.dev) {
    // Watch the input directory or parent directory of input file
    final Directory directoryToWatch;
    if (input is Directory) {
      directoryToWatch = input;
    } else {
      directoryToWatch = (input as File).parent;
    }

    if (await directoryToWatch.exists()) {
      await for (final _ in directoryToWatch.watch()) {
        await processFiles();
      }
    }
  }

  for (final ar in aktorRunners) {
    await ar.wait();
  }

  stdout.writeln(green("Done!"));

  return 0;
}
