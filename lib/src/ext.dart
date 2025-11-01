import 'dart:convert';
import 'dart:io';

import 'package:async/async.dart';
import 'package:path/path.dart';

/// Type alias for StringBuffer.
typedef Buf = StringBuffer;

extension StringSinkX on StringSink {
  /// Writes a string (shorthand for write).
  void w(String s) => write(s);

  /// Writes a newline character.
  void nl() => w('\n');

  /// Writes a string followed by a newline.
  void l(String s) {
    w(s);
    nl();
  }

  /// Writes indentation (tabs).
  void i([int level = 1]) => w('\t' * level);
}

extension TX<T> on T {
  /// Checks if this value is one of the provided options.
  bool isOneOf(List<T> options) => options.any((o) => o == this);
}

extension IterableOfIntX on Iterable<int> {
  /// Maximum value in this iterable.
  int get max => reduce((a, b) => a > b ? a : b);

  /// Minimum value in this iterable.
  int get min => reduce((a, b) => a < b ? a : b);
}

extension MapX<K, V> on Map<K, V> {
  /// Expands map entries into an iterable of tuples (key, value).
  Iterable<(K, V)> get expand => entries.map((e) => (e.key, e.value));
}

extension StreamX<T> on Stream<T> {
  /// Filters stream to only emit items of type E.
  Stream<E> whereType<E>() async* {
    await for (final item in this) {
      if (item is E) {
        yield item;
      }
    }
  }
}

extension StringX on String {
  /// Creates a Directory from this path string.
  Directory get dir => Directory(this);

  /// Creates a File from this path string.
  File get file => File(this);
}

extension DirectoryX on Directory {
  /// Gets a subdirectory by joining this directory's path with path.
  Directory d(String path) => join(this.path, path).dir;

  /// Gets a file in this directory by joining this directory's path with path.
  File f(String path) => join(this.path, path).file;

  /// Creates a new temporary path in this directory.
  Future<String> newTempPath({String? prefix, String? suffix}) async {
    prefix ??= "";
    suffix ??= "";

    int i = 0;
    while (true) {
      final name = "$prefix$i$suffix";
      final path = join(this.path, name);

      if (await FileSystemEntity.type(path) == FileSystemEntityType.notFound) {
        return path;
      }

      i++;
    }
  }

  /// Creates a new temporary file in this directory.
  Future<File> newTempFile({String? prefix, String? suffix}) async {
    final file = await newTempPath(
      prefix: prefix,
      suffix: suffix,
    ).then((v) => v.file);
    await file.create(recursive: true);
    return file;
  }

  /// Creates a new temporary directory in this directory.
  Future<Directory> newTempDir({String? prefix, String? suffix}) async {
    final dir = await newTempPath(
      prefix: prefix,
      suffix: suffix,
    ).then((v) => v.dir);
    await dir.create(recursive: true);
    return dir;
  }
}

extension FileSystemEntityX on FileSystemEntity {
  /// Name (basename) of this file system entity.
  String get name => basename(path);
}

extension FileX on File {
  /// File name without its extension.
  String get nameWithoutExt {
    final index = name.lastIndexOf('.');
    if (index == -1) return name; // no extension
    return name.substring(0, index);
  }
}

Future<void> cmd(
  String exe, {
  List<String>? args,
  Map<String, String>? env,
  Directory? dWork,
  bool verbose = true,
}) async {
  args ??= [];
  env ??= {};
  dWork ??= Directory.current;

  final process = await Process.start(
    exe,
    args,
    environment: env,
    workingDirectory: dWork.path,
  );
  final stream = StreamGroup.merge([process.stdout, process.stderr]);
  if (verbose) {
    await for (final line in LineSplitter().bind(Utf8Decoder().bind(stream))) {
      stdout.writeln(line);
    }
  } else {
    await stream.drain();
  }
  final exitCode = await process.exitCode;
  if (exitCode != 0) {
    throw Exception("Command failed with exit code $exitCode");
  }
}
