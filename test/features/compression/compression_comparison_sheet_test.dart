import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:minimo_photo/features/compression/bloc/compress_state.dart';
import 'package:minimo_photo/features/compression/domain/compression_result.dart';
import 'package:minimo_photo/features/compression/domain/picked_photo.dart';
import 'package:minimo_photo/features/compression/presentation/widgets/compression_comparison_sheet.dart';
import 'package:minimo_photo/generated/l10n.dart';

void main() {
  Future<void> pumpSheet(
    WidgetTester tester, {
    required File original,
    required File compressed,
  }) {
    return tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        home: Scaffold(
          body: CompressionComparisonSheet(
            results: [
              CompressedPhoto(
                source: PickedPhoto(
                  path: original.path,
                  name: 'photo.png',
                  size: 100,
                ),
                result: CompressionResult(
                  success: true,
                  originalSize: 100,
                  outputSize: 50,
                  outputPath: compressed.path,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> precacheFiles(WidgetTester tester, List<File> files) async {
    imageCache
      ..clear()
      ..clearLiveImages();
    await tester.runAsync(() async {
      for (final file in files) {
        final completer = Completer<void>();
        final stream = FileImage(file).resolve(ImageConfiguration.empty);
        late final ImageStreamListener listener;
        listener = ImageStreamListener(
          (info, _) {
            info.dispose();
            stream.removeListener(listener);
            completer.complete();
          },
          onError: (error, stack) {
            stream.removeListener(listener);
            completer.completeError(error, stack);
          },
        );
        stream.addListener(listener);
        await completer.future;
      }
    });
  }

  testWidgets('comparison matches the split before-and-after layout', (
    tester,
  ) async {
    await pumpSheet(
      tester,
      original: File('assets/logo/logo.png').absolute,
      compressed: File('assets/logo/logo-dark.png').absolute,
    );

    expect(find.text('compare'), findsOneWidget);
    expect(find.byKey(const Key('comparison-original')), findsOneWidget);
    expect(find.byKey(const Key('comparison-compressed')), findsOneWidget);
    expect(find.byKey(const Key('comparison-divider')), findsOneWidget);
    expect(find.text('before'), findsOneWidget);
    expect(find.text('after'), findsOneWidget);

    final divider = find.byKey(const Key('comparison-divider'));
    final startX = tester.getCenter(divider).dx;

    await tester.drag(
      find.byKey(const Key('comparison-handle')),
      const Offset(-120, 0),
    );
    await tester.pump();

    expect(tester.getCenter(divider).dx, closeTo(startX - 120, 1));
  });

  testWidgets('split frame tolerates rounding in compressed dimensions', (
    tester,
  ) async {
    final original = File('assets/logo/logo.png').absolute;
    final compressed = File('assets/logo/video.png').absolute;
    await precacheFiles(tester, [original, compressed]);
    await pumpSheet(tester, original: original, compressed: compressed);
    await tester.pump();

    expect(find.byKey(const Key('comparison-divider')), findsOneWidget);
    expect(find.byKey(const Key('comparison-side-by-side')), findsNothing);
    final frame = tester.getSize(find.byKey(const Key('comparison-original')));
    expect(frame.width, closeTo(frame.height, 0.5));
  });

  testWidgets('mismatched aspect ratios fall back to side by side', (
    tester,
  ) async {
    final original = File('assets/logo/logo.png').absolute;
    final compressed = File(
      '${Directory.systemTemp.createTempSync('comparison').path}/wide.png',
    );
    await tester.runAsync(() async {
      final recorder = ui.PictureRecorder();
      Canvas(recorder).drawRect(
        const Rect.fromLTWH(0, 0, 200, 100),
        Paint()..color = Colors.red,
      );
      final image = await recorder.endRecording().toImage(200, 100);
      final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
      image.dispose();
      await compressed.writeAsBytes(bytes!.buffer.asUint8List());
    });
    addTearDown(() => compressed.parent.deleteSync(recursive: true));

    await precacheFiles(tester, [original, compressed]);
    await pumpSheet(tester, original: original, compressed: compressed);
    await tester.pump();

    expect(find.byKey(const Key('comparison-side-by-side')), findsOneWidget);
    expect(find.byKey(const Key('comparison-divider')), findsNothing);
    expect(find.byKey(const Key('comparison-original')), findsOneWidget);
    expect(find.byKey(const Key('comparison-compressed')), findsOneWidget);
    expect(find.text('before'), findsOneWidget);
    expect(find.text('after'), findsOneWidget);
  });
}
