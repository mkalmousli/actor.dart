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
