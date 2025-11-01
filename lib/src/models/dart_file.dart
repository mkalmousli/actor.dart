import 'dart:io';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:aktor/src/const.dart';
import 'package:aktor/src/ext.dart';
import 'package:aktor/src/asset_reader.dart';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:collection/collection.dart';
import 'package:aktor/src/models/aktor.dart';

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
}

extension CompilationUnitX on CompilationUnit {
  /// Extracts all aktor functions from this compilation unit.
  Iterable<Aktor> getAktors(String fileContent, [String? prefix]) sync* {
    final expectedAnnoName = switch (prefix) {
      null => Const.annotationName,
      String v => "$v.${Const.annotationName}",
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

      final offset = method.returnType?.offset ?? 0;

      final lineNumber = fileContent.substring(0, offset).split('\n').length;
      final columnNumber =
          offset - fileContent.substring(0, offset).lastIndexOf('\n');

      yield Aktor(
        functionName: methodName,
        isAsync: isAsync,
        requireContext: requireContext,
        lineNumber: lineNumber,
        columnNumber: columnNumber,
      );
    }
  }
}
