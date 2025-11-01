///
/// The annotation to mark a function as an aktor.
/// It is used to extract the aktor from the function.
///
/// Example:
/// ```dart
/// @aktor
/// Future<void> sayHello(C c)async {
///   print("Hello, world!");
/// }
/// ```
///
const aktor = AktorAnnotation._();

class AktorAnnotation {
  const AktorAnnotation._();
}

///
/// Optional annotation to mark an aktor as live-reloadable.
/// When present, the aktor will be restarted whenever the file
/// or its dependencies (imports, parts, part ofs) change.
///
/// It requires the @aktor annotation to be present.
///
/// Example:
/// ```dart
/// @aktor
/// @live
/// Future<void> sayHello(C c) async {
///   print("Hello, world!");
/// }
/// ```
///
const live = LiveAnnotation._();

class LiveAnnotation {
  const LiveAnnotation._();
}
