import 'dart:convert';
import 'dart:io';

import 'package:aktor/src/models/aktor.dart';
import 'package:aktor/src/models/dart_file.dart';
import 'package:aktor/src/models/mode.dart';
import 'package:aktor/src/const.dart';
import 'package:aktor/src/ext.dart';
import 'package:ansi/ansi.dart';
import 'package:async/async.dart';
import 'package:bloc/bloc.dart' as bloc;
import 'dart:async';
import 'package:path/path.dart';
import 'state.dart' as s;
import 'event.dart' as e;

/// Manages aktor process lifecycle using BLoC pattern.
class AktorRunner extends bloc.Bloc<e.Event, s.State> {
  /// Aktor configuration.
  final Aktor aktor;

  /// Dart file containing the aktor function.
  final DartFile dartFile;

  /// Root directory of the Dart project.
  final Directory dRoot;

  /// Future that completes when the process exits or runner file is deleted.
  Future<void>? _completionFuture;

  /// Completer for waiting until the process starts.
  final _startCompleter = Completer<void>();

  /// Completer for waiting until the process stops.
  Completer<void>? _stopCompleter;

  /// Creates an AktorRunner for the given aktor and configuration.
  AktorRunner({
    required this.aktor,
    required this.dartFile,
    required this.dRoot,
    required s.State initialState,
  }) : super(initialState) {
    on<e.Event>(
      (event, emit) => event.when<void>(
        start: (mode) async {
          if (!state.maybeWhen(initial: () => true, orElse: () => false)) {
            return;
          }

          emit( s.State.starting());

          try {
            final fRunner = await dRoot
                .d(".dart_tool")
                .d("Aktor")
                .d(".Runners")
                .newTempFile(suffix: ".dart");

            final fMain = dartFile.when(
              main: (file, aktors) => file,
              part: (mainFile, file, aktors) => mainFile,
            );

            final b = Buf();
            b.w("import 'dart:io' as _io;");
            b.w("import '${Const.importPath}' as _aktor;");
            b.w(
              "import '${relative(fMain.path, from: fRunner.parent.path)}' as _method;",
            );

            b.w("const mode = _aktor.Mode.${mode.name};");

            if (aktor.requireContext) {
              b.w("final context = _aktor.AktorContext(");
              b.w("mode: _aktor.Mode.${mode.name},");
              b.w("file: _io.File('${fMain.path}'),");
              b.w("root: _io.Directory('${dRoot.path}')");
              b.w(");");
            }

            b.w("void main() => ");
            if (aktor.isAsync) b.w("await ");
            b.w("_method.${aktor.functionName}(");
            if (aktor.requireContext) b.w("context");
            b.w(");");

            await fRunner.writeAsString(b.toString());

            final process = await Process.start("dart", ["run", fRunner.path]);

            emit(s.State.running(process: process, runnerFile: fRunner));

            if (!_startCompleter.isCompleted) {
              _startCompleter.complete();
            }

            Future<void> killOnFileRemove() async {
              try {
                await fRunner
                    .watch()
                    .where((e) => e.type == FileSystemEvent.delete)
                    .first;
                add(const e.Event.fileDeleted());
              } catch (_) {}
            }

            Future<void> waitForCompletion() async {
              final prefix =
                  "${relative(dartFile.file.path, from: dRoot.path)}:${aktor.lineNumber}:${aktor.columnNumber} #${aktor.functionName}";

              stdout.writeln(blue("$prefix started."));

              final lines = LineSplitter()
                  .bind(
                    Utf8Decoder().bind(
                      StreamGroup.merge([process.stdout, process.stderr]),
                    ),
                  )
                  .map((line) => "$prefix :: $line");

              await for (final line in lines) {
                final currentState = state;
                final isStopping = currentState.maybeWhen(
                  stopping: (p, f) => true,
                  orElse: () => false,
                );
                if (!isStopping) {
                  stdout.writeln(line);
                }
              }

              final exitCode = await process.exitCode;

              final finalState = state;
              final wasStopping = finalState.maybeWhen(
                stopping: (p, f) => true,
                orElse: () => false,
              );

              if (wasStopping) {
                emit(s.State.stopped(runnerFile: fRunner));
                stdout.writeln(red("$prefix is killed."));
              } else if (exitCode == 0) {
                emit(
                  s.State.completed(exitCode: exitCode, runnerFile: fRunner),
                );
                stdout.writeln(green("$prefix is done."));
              } else {
                emit(s.State.failed(exitCode: exitCode, runnerFile: fRunner));
                stdout.writeln(red("$prefix FAILED WITH $exitCode!"));
              }

              await _cleanupFile(fRunner);
            }

            _completionFuture = Future.wait([
              waitForCompletion(),
              killOnFileRemove(),
            ]);
          } catch (error) {
            emit(s.State.failed(exitCode: -1, runnerFile: null));
            if (!_startCompleter.isCompleted) {
              _startCompleter.completeError(error);
            }
            rethrow;
          }
        },
        stop: () async {
          final handled = await state.whenOrNull(
            running: (process, runnerFile) async {
              emit(s.State.stopping(process: process, runnerFile: runnerFile));

              try {
                process.kill(ProcessSignal.sigabrt);
                await process.exitCode;
              } catch (_) {}

              await _cleanupFile(runnerFile);
              emit(s.State.stopped(runnerFile: runnerFile));
              return true;
            },
            starting: () async {
              emit(const s.State.stopped(runnerFile: null));
              return true;
            },
          );

          if (_stopCompleter != null && !_stopCompleter!.isCompleted) {
            _stopCompleter!.complete();
          }

          if (handled == null) {}
        },
        fileDeleted: () async {
          await state.whenOrNull(
            running: (process, runnerFile) async {
              emit(s.State.stopping(process: process, runnerFile: runnerFile));

              try {
                process.kill(ProcessSignal.sigabrt);
                await process.exitCode;
              } catch (_) {}

              emit(s.State.stopped(runnerFile: runnerFile));
            },
          );
        },
      ),
    );
  }

  /// Starts the runner with the given execution mode.
  Future<void> start(Mode mode) async {
    add(e.Event.start(mode: mode));
    await _startCompleter.future;
  }

  /// Stops the runner gracefully and closes the BLoC.
  Future<void> stop() async {
    _stopCompleter = Completer<void>();
    add(const e.Event.stop());
    await _stopCompleter?.future;
    await close();
  }

  /// Waits for the runner to complete.
  Future<void> wait() async {
    await _completionFuture;
  }

  /// Deletes the runner file, ignoring errors.
  Future<void> _cleanupFile(File? runnerFile) async {
    if (runnerFile == null) return;

    try {
      await runnerFile.delete(recursive: true);
    } catch (_) {
      // Ignore deletion errors (file may already be deleted)
    }
  }
}
