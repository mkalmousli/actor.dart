import 'package:aktor/aktor.dart';
import 'package:aktor/src/ext.dart';

@live
@aktor
Future<void> exportLOGO(C c) async {
  final fSvg = c.root.f("Logo.svg");
  final fProdSvg = c.root.f("LogoProd.svg");
  final fProdPng = c.root.f("LogoProd.png");

  Future<void> export() async {
    await Future.wait([
      cmd("inkscape", args: [fSvg.path, "-o", fProdSvg.path]),
      cmd(
        "inkscape",
        args: ["-w", "500", "-h", "500", fProdSvg.path, "-o", fProdPng.path],
      ),
    ]);
    print("Exported");
  }

  await export();

  if (c.mode == Mode.dev) {
    DateTime lastExport = DateTime.now();
    await for (final _ in fSvg.watch()) {
      final now = DateTime.now();
      if (now.difference(lastExport).inMilliseconds > 1000) {
        lastExport = now;
        await export();
      }
    }
  }
}
