import 'package:freezed_annotation/freezed_annotation.dart';

part 'aktor.freezed.dart';

@freezed
abstract class Aktor with _$Aktor {
  const factory Aktor({
    /// Function name.
    required String functionName,

    /// Line number where the function is located.
    required int lineNumber,

    /// Column number where the function is located.
    required int columnNumber,

    /// Whether the method is asynchronous.
    @Default(false) bool isAsync,

    /// Whether the method requires a context.
    @Default(false) bool requireContext,

    /// Whether the aktor is marked with @live annotation.
    @Default(false) bool isLive,
  }) = _Aktor;
}
