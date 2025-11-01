import 'dart:io';

/// Reads and caches file contents in memory.
class AssetReader {
  final _cache = <String, String>{};

  /// Reads a file, using cache if available.
  Future<String> read(String path) async {
    var value = _cache[path];
    if (value == null) {
      final newValue = await File(path).readAsString();
      _cache[path] = newValue;
      value = newValue;
    }
    return value;
  }

  /// Clears the cache.
  void clearCache() {
    _cache.clear();
  }
}
