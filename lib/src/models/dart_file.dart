import 'dart:io';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:aktor/src/const.dart';
import 'package:aktor/src/ext.dart';
import 'package:aktor/src/asset_reader.dart';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:collection/collection.dart';
import 'package:aktor/src/models/aktor.dart';
import 'package:path/path.dart' as p;

part 'dart_file.freezed.dart';

/// Represents a Dart file, either main or part.
@freezed
abstract class DartFile with _$DartFile {
  /// A main Dart file.
  const factory DartFile.main({
    required File file,
    required List<Aktor> aktors,
  }) = MainFile;

  /// A part file.
  const factory DartFile.part({
    required File mainFile,
    required File file,
    required List<Aktor> aktors,
  }) = PartFile;

  /// Parses a DartFile from a File.
  static Future<DartFile> parse(File file, AssetReader assetReader) async {
    final fileContent = await assetReader.read(file.path);

    final fileParseResult = parseString(content: fileContent, path: file.path);
    final fileAst = fileParseResult.unit;

    final isMain = fileAst.directives.whereType<PartOfDirective>().isEmpty;

    final File fMain;
    if (isMain) {
      fMain = file;
    } else {
      final partOf = fileAst.directives.whereType<PartOfDirective>().first;
      fMain = await partOf.uri!.stringValue
          .toString()
          .file
          .resolveSymbolicLinks()
          .then((v) => v.file);
    }

    final mainFileContent = switch (isMain) {
      true => fileContent,
      false => await assetReader.read(fMain.path),
    };

    final mainParseResult = switch (isMain) {
      true => fileParseResult,
      false => parseString(content: mainFileContent, path: fMain.path),
    };

    final mainAst = switch (isMain) {
      true => fileAst,
      false => mainParseResult.unit,
    };

    final imports = mainAst.directives.whereType<ImportDirective>();

    final aktorImport = imports
        .where((imp) => imp.uri.stringValue == Const.importPath)
        .firstOrNull;

    final isImported = aktorImport != null;

    final aktors = <Aktor>[];
    if (isImported) {
      final aktorPrefix = aktorImport.prefix?.name;
      aktors.addAll(fileAst.getAktors(fileContent, aktorPrefix));
    }

    if (isMain) {
      return DartFile.main(file: file, aktors: aktors);
    } else {
      return DartFile.part(mainFile: fMain, file: file, aktors: aktors);
    }
  }
}

extension DartFileX on DartFile {
  /// File for both main and part files.
  File get file => when(
    main: (file, aktors) => file,
    part: (mainFile, file, aktors) => file,
  );

  /// Aktors list for both main and part files.
  List<Aktor> get aktors => when(
    main: (file, aktors) => aktors,
    part: (mainFile, file, aktors) => aktors,
  );

  /// Main file for both main and part files.
  File get mainFile => when(
    main: (file, aktors) => file,
    part: (mainFile, file, aktors) => mainFile,
  );

  /// Extracts all dependency file paths (imports, parts, part ofs) from this Dart file.
  /// Returns a set of file paths that this file depends on.
  Future<Set<String>> getDependencies(AssetReader assetReader) async {
    final mainFile = this.mainFile;
    final fileContent = await assetReader.read(mainFile.path);
    final parseResult = parseString(content: fileContent, path: mainFile.path);
    final ast = parseResult.unit;

    final dependencies = <String>{};
    dependencies.add(mainFile.path);

    final mainFileDir = mainFile.parent.path;

    // Helper to resolve URI relative to main file
    Future<File?> resolveUri(String uriString) async {
      if (uriString.isEmpty) return null;

      // Skip package and dart: imports
      if (uriString.startsWith('package:') || uriString.startsWith('dart:')) {
        return null;
      }

      try {
        // Resolve relative to main file's directory
        final resolvedPath = p.normalize(p.join(mainFileDir, uriString));
        var file = File(resolvedPath);

        // Handle .dart extension if not present
        if (!resolvedPath.endsWith('.dart')) {
          file = File('$resolvedPath.dart');
        }

        final resolved = await file.resolveSymbolicLinks();
        final resolvedFile = File(resolved);

        if (await resolvedFile.exists()) {
          return resolvedFile;
        }
      } catch (_) {
        // Skip if URI cannot be resolved
      }

      return null;
    }

    // Add part files
    final parts = ast.directives.whereType<PartDirective>();
    for (final part in parts) {
      final uriString = part.uri.stringValue ?? '';
      final partFile = await resolveUri(uriString);
      if (partFile != null) {
        dependencies.add(partFile.path);
      }
    }

    // Add imports (only relative imports, skip packages)
    final imports = ast.directives.whereType<ImportDirective>();
    for (final import in imports) {
      final uriString = import.uri.stringValue ?? '';
      final importFile = await resolveUri(uriString);
      if (importFile != null) {
        dependencies.add(importFile.path);
      }
    }

    // Add part of file if this is a part
    final partOfs = ast.directives.whereType<PartOfDirective>();
    for (final partOf in partOfs) {
      final uriString = partOf.uri?.stringValue ?? '';
      final partOfFile = await resolveUri(uriString);
      if (partOfFile != null) {
        dependencies.add(partOfFile.path);
      }
    }

    return dependencies;
  }
}

extension CompilationUnitX on CompilationUnit {
  /// Extracts all aktor functions from this compilation unit.
  Iterable<Aktor> getAktors(String fileContent, [String? prefix]) sync* {
    final expectedAnnoName = switch (prefix) {
      null => Const.annotationName,
      String v => "$v.${Const.annotationName}",
    };

    final expectedLiveAnnoName = switch (prefix) {
      null => "live",
      String v => "$v.live",
    };

    final methods = declarations.whereType<FunctionDeclaration>();

    final aktorMethods = <FunctionDeclaration>[];

    for (final method in methods) {
      for (final anonotation in method.metadata) {
        final name = anonotation.name.name;
        if (name == expectedAnnoName) {
          aktorMethods.add(method);
          break;
        }
      }
    }

    for (final method in aktorMethods) {
      final methodName = method.name.value().toString();
      final isPrivate = methodName.startsWith("_");

      if (isPrivate) continue;

      final isAsync = switch (method.returnType) {
        NamedType v => v.type?.isDartAsyncFuture ?? false,
        _ => false,
      };

      final requireContext =
          (method.functionExpression.parameters?.parameters.length ?? 0) >= 1;

      // Check for @live annotation
      bool isLive = false;
      for (final annotation in method.metadata) {
        final name = annotation.name.name;
        if (name == expectedLiveAnnoName) {
          isLive = true;
          break;
        }
      }

      final offset = method.returnType?.offset ?? 0;

      final lineNumber = fileContent.substring(0, offset).split('\n').length;
      final columnNumber =
          offset - fileContent.substring(0, offset).lastIndexOf('\n');

      yield Aktor(
        functionName: methodName,
        isAsync: isAsync,
        requireContext: requireContext,
        isLive: isLive,
        lineNumber: lineNumber,
        columnNumber: columnNumber,
      );
    }
  }
}
