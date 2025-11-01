import 'package:aktor/src/models/mode.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'event.freezed.dart';

/// Events that can be dispatched to the AktorRunner BLoC.
@freezed
sealed class Event with _$Event {
  /// Starts the aktor with the given execution mode.
  const factory Event.start({required Mode mode}) = Start;

  /// Stops the currently running aktor.
  const factory Event.stop() = Stop;

  /// Notifies that the runner file has been deleted.
  const factory Event.fileDeleted() = FileDeleted;
}
