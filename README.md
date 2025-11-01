<img src="LogoProd.svg" width="200">

<br/>

> "*Make code work for you*"

A simple tool that solves [Dart](https://dart.dev/)'s lack of metaprogramming features.

Perfect for building scripts, background jobs, scheduled tasks, and development utilities like **code generation**, **data processing**, and more.


Here is a extremely simple aktor:

```dart
import 'package:aktor/aktor.dart';

@live
@aktor
Future<void> sayHello() async {
    print("Hello, world!");
}
```

Here is how to run it:
```bash
dart run aktor --dev
```

Now, change the code and see the aktor restart!

Here is a recorded demo:

<a href="https://asciinema.org/a/753074">
  <img src="https://asciinema.org/a/753074.svg" width="300">
</a>


## Why?

In January 2025, the Dart team made the difficult decision to [stop work on macros](https://medium.com/@vijay.menon/an-update-on-dart-macros-data-serialization-2bd147e4b4a0) after years of development. Despite significant investment, macros were facing fundamental technical challenges that made it difficult to ship.

This leaves a gap in the Dart ecosystem for code generation and metaprogramming needs. While [`build_runner`](https://pub.dev/packages/build_runner) exists as a solution, many developers find it complex, **slow** (very slow in fact), and hard to maintain.

`aktor` is meant to be a simpler, more maintainable alternative. Instead of complex code generation systems that aren't flexible enough and very disconnected from each other, `aktor` lets you write small, focused programs (called **aktors**) that do precisely what you want.

## Installation

### Globally (Recommended)

```bash
dart pub global activate aktor
```

And then you can run `aktor` from anywhere:
```bash
aktor
```

### For a Specific Project

Add `aktor` to your `pubspec.yaml`:

```yaml
dev_dependencies:
  aktor: ^0.0.1
```

And then update your dependencies:

```bash
dart pub get
```

## Quick Start

1. Create a Dart file with an aktor function:

```dart
import 'package:aktor/aktor.dart';

@aktor
Future<void> sayHello() async {
  print("Hello, world!");
}
```

2. Run the aktor:

```bash
# Production mode (run once)
dart run aktor

# Development mode (watch for changes)
dart run aktor --dev
```

## Usage

### Basic Aktor

The simplest aktor is just a function with the `@aktor` annotation:

```dart
@aktor
Future<void> myAktor() async {
  print("Running my aktor!");
}
```

### Aktor with Context

Aktors can optionally receive an `AktorContext` (aliased as `C`) as their first parameter to access execution information:

```dart
@aktor
Future<void> myAktor(C c) async {
  print("Mode: ${c.mode}");
  print("File: ${c.file.path}");
  print("Root: ${c.root.path}");
  print("Directory: ${c.dir.path}");
}
```

The context provides:
- `mode`: Current execution mode (`prod` or `dev`)
- `file`: The Dart file containing the aktor
- `root`: The root directory of the Dart project
- `dir`: Convenience getter for the file's directory

### Live Aktors (Auto-Reload)

Aktors can be marked with the `@live` annotation to enable **automatic dependency-based reloading** in development mode. When a live aktor's dependencies (imported files, parts, etc.) change, it automatically restarts:

```dart
@aktor
@live
Future<void> myServer(C c) async {
  // This aktor will automatically restart when any imported file changes
  print("Server running...");
}
```

**How it works:**
- Live aktors are marked with a `*` in the CLI output
- The tool automatically tracks all dependencies (imports, parts, etc.) of live aktors
- When any dependency file changes, the live aktor is automatically restarted
- Debounced to handle rapid file changes efficiently (200ms delay)
- Only works in development mode (`--dev`)

Perfect for:
- Long-running services and servers
- File watchers and monitors
- Development utilities that need to stay running
- Any aktor that should react to dependency changes

### Command Line Options

The CLI provides an improved experience with color-coded output, status indicators, and smart path handling:

```bash
# Run in production mode (default)
aktor [directory]

# Run in development mode (watch for changes)
aktor --dev [directory]
aktor -d [directory]

# Show version
aktor --version
aktor -v
```


### Execution Modes

#### Production Mode (default)

In production mode, aktors run once and the program exits after all aktors complete:

```bash
aktor
```

Perfect for:
- Scripts and automation tasks
- Scheduled jobs
- One-time data processing
- CI/CD pipelines

#### Development Mode

In development mode, the tool watches for file changes and automatically restarts aktors:

```bash
aktor --dev
```

Perfect for:
- Local development
- Testing aktor functions
- Live reload during development
- Background services during development

## How It Works

1. **Discovery**: The tool scans your Dart project (or specified directory) for `.dart` files
2. **Parsing**: It parses each file to find functions annotated with `@aktor`
3. **Generation**: For each aktor, it generates a temporary runner file
4. **Execution**: Each aktor runs in its own Dart process
5. **Lifecycle Management**: The tool manages the lifecycle of all aktor processes

In development mode, the tool also:
- Watches for file changes
- Re-evaluates aktors when files are modified
- Automatically starts new aktors and stops removed ones
- Maintains running aktors across file changes
- **Live aktors** (`@live`) automatically restart when their dependencies change

## Project Structure

The tool automatically:
- Finds your project root (by locating `pubspec.yaml`)
- Scans recursively through directories
- Ignores build artifacts (`.dart_tool`, `build`, `.dyn`)
- Creates temporary runner files in `.dart_tool/Aktor/.Runners/`
