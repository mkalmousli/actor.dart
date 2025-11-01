/// Execution mode for aktor.
enum Mode {
  /// Production mode - aktor run once and exit.
  prod,

  /// Development mode - aktor are watched and restart on file changes.
  dev,
}
