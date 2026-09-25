import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:minimo_photo/features/compression/bloc/compress_state.dart';
import 'package:minimo_photo/features/compression/domain/compression_result.dart';
import 'package:minimo_photo/features/compression/domain/picked_photo.dart';
import 'package:minimo_photo/features/compression/presentation/widgets/compression_comparison_sheet.dart';
import 'package:minimo_photo/generated/l10n.dart';

void main() {
  testWidgets('comparison matches the split before-and-after layout', (
    tester,
  ) async {
    final original = File('assets/logo/logo.png').absolute;
    final compressed = File('assets/logo/logo-dark.png').absolute;

    await tester.pumpWidget(
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
    expect(find.text('compare'), findsOneWidget);
    expect(find.byKey(const Key('comparison-original')), findsOneWidget);
    expect(find.byKey(const Key('comparison-compressed')), findsOneWidget);
    expect(find.byKey(const Key('comparison-divider')), findsOneWidget);
    expect(find.text('before'), findsOneWidget);
    expect(find.text('after'), findsOneWidget);
  });
}
