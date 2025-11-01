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

  stdout.writeln(blue("Mode: ${mode.name}"));

  final dCurrent = Directory.current;

  final Directory dInput;
  if (pathArgs.isEmpty) {
    dInput = dCurrent;
  } else {
    dInput = Directory(pathArgs.first);
  }

  final Directory dRoot = await () async {
    Directory dir = dCurrent;

    while (true) {
      if (await dir.f("pubspec.yaml").exists()) {
        return dir;
      }

      dir = dir.parent;
      if (dir.path == dCurrent.path) break;
    }

    throw Exception("Couldn't find root package folder!");
  }();

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

  final allDartFiles = <DartFile>{};
  final aktorRunners = <b_aktor_runner.AktorRunner>{};

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
      await runner?.stop();
      aktorRunners.remove(runner);
    }

    allDartFiles.add(dartFile);
  }

  int iCycle = 0;

  /// Processes all Dart files in the input directory.
  Future<void> processFiles() async {
    iCycle += 1;
    final isFirstCycle = iCycle == 1;

    if (aktorRunners.isEmpty) {
      stdout.writeln(yellow("Searching for aktors..."));
    }

    final assetReader = AssetReader();
    await for (final file in getInputFiles(dInput)) {
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
    await for (final _ in dInput.watch()) {
      await processFiles();
    }
  }

  for (final ar in aktorRunners) {
    await ar.wait();
  }

  stdout.writeln(green("Done!"));

  return 0;
}
