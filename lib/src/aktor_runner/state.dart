import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

/// State of an AktorRunner during its lifecycle.
@freezed
sealed class State with _$State {
  /// Initial state before the aktor has been started.
  const factory State.initial() = Initial;

  /// Aktor is in the process of starting up.
  const factory State.starting() = Starting;

  /// Aktor is currently running.
  const factory State.running({
    required Process process,
    required File runnerFile,
  }) = Running;

  /// Aktor is in the process of stopping.
  const factory State.stopping({
    required Process process,
    required File runnerFile,
  }) = Stopping;

  /// Aktor has completed successfully.
  const factory State.completed({required int exitCode, File? runnerFile}) =
      Completed;

  /// Aktor has failed during execution.
  const factory State.failed({required int exitCode, File? runnerFile}) =
      Failed;

  /// Aktor has been stopped.
  const factory State.stopped({File? runnerFile}) = Stopped;
}
