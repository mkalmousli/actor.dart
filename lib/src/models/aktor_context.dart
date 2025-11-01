import 'dart:io';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:aktor/src/models/mode.dart';

part 'aktor_context.freezed.dart';

/// Context passed to aktor functions when they require context.
@freezed
abstract class AktorContext with _$AktorContext {
  /// Creates an AktorContext with the given parameters.
  const factory AktorContext({
    required Mode mode,
    required File file,
    required Directory root,
  }) = _AktorContext;

  const AktorContext._();

  /// Directory containing the file.
  Directory get dir => file.parent;
}

/// Type alias for [AktorContext].
typedef C = AktorContext;
