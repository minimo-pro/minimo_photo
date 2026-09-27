import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:minimo_photo/features/compression/bloc/compress_bloc.dart';
import 'package:minimo_photo/features/compression/bloc/compress_event.dart';
import 'package:minimo_photo/features/compression/data/photo_compressor_adapter.dart';
import 'package:minimo_photo/features/compression/domain/compression_settings.dart';
import 'package:minimo_photo/features/compression/domain/picked_photo.dart';
import 'package:minimo_photo/features/compression/presentation/widgets/selected_photos_summary.dart';
import 'package:minimo_photo/generated/l10n.dart';
import 'package:minimo_photo/widgets/rolling_counter_text.dart';

void main() {
  test('refresh retains numbers and ignores an obsolete result', () async {
    final codec = _ControlledEstimator();
    final bloc = CompressBloc(
      initialPhotos: const [
        PickedPhoto(path: 'photo.jpg', name: 'photo.jpg', size: 1000),
      ],
      photoCompressorAdapter: codec,
    );
    addTearDown(bloc.close);
    await bloc.stream.firstWhere((s) => s.estimatedSize == 800);
    bloc.add(const CompressSettingsChanged(CompressionSettings(quality: 72)));
    final refreshing = await bloc.stream.firstWhere(
      (s) => s.settings.quality == 72,
    );
    expect(refreshing.estimatedSize, 800);
    expect(refreshing.isEstimating, isTrue);
    await codec.started.future;
    bloc.add(const CompressSettingsChanged(CompressionSettings(quality: 60)));
    await bloc.stream.firstWhere((s) => s.estimatedSize == 500);
    expect(codec.cancelled!(), isTrue);
    codec.stale.complete(700);
    await Future<void>.delayed(Duration.zero);
    expect(bloc.state.estimatedSize, 500);
    expect(bloc.state.isEstimating, isFalse);
  });

  for (final compact in [true, false]) {
    testWidgets(
      'summary keeps geometry during calculation (compact: $compact)',
      (tester) async {
        const rowKey = ValueKey('size-row');
        const belowKey = ValueKey('below-summary');
        Future<void> show(int? estimate, int? percent, bool calculating) async {
          await tester.pumpWidget(
            MaterialApp(
              localizationsDelegates: const [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              supportedLocales: S.delegate.supportedLocales,
              home: Scaffold(
                body: Column(
                  children: [
                    SelectedPhotosSummary(
                      sizeRowKey: rowKey,
                      selectedCount: 1,
                      thumbnailPaths: const [null],
                      originalSize: 1000,
                      estimatedSize: estimate,
                      savingsPercent: percent,
                      isEstimating: calculating,
                      compact: compact,
                    ),
                    const SizedBox(key: belowKey, height: 20),
                  ],
                ),
              ),
            ),
          );
          await tester.pumpAndSettle();
        }

        await show(null, null, true);
        final rowRect = tester.getRect(find.byKey(rowKey));
        final below = tester.getTopLeft(find.byKey(belowKey));
        await show(800, 20, false);
        final counterState = tester.state(
          find.byType(RollingCounterText).first,
        );
        expect(tester.getRect(find.byKey(rowKey)), rowRect);
        expect(tester.getTopLeft(find.byKey(belowKey)), below);
        await show(800, 20, true);
        expect(
          tester.state(find.byType(RollingCounterText).first),
          same(counterState),
        );
        await show(500, 50, false);
        expect(
          tester.state(find.byType(RollingCounterText).first),
          same(counterState),
        );
        await show(1000, 0, false);
        expect(tester.getRect(find.byKey(rowKey)), rowRect);
        expect(tester.getTopLeft(find.byKey(belowKey)), below);
        expect(tester.takeException(), isNull);
      },
    );
  }
}

class _ControlledEstimator extends PhotoCompressorAdapter {
  final started = Completer<void>();
  final stale = Completer<int?>();
  bool Function()? cancelled;

  @override
  Future<String?> createThumbnail(String inputPath) async => null;

  @override
  Future<int?> estimateCompressedSize(
    Iterable<PickedPhoto> photos,
    CompressionSettings settings, {
    bool Function()? isCancelled,
  }) async {
    if (settings.quality == 72) {
      cancelled = isCancelled;
      started.complete();
      return stale.future;
    }
    return settings.quality == 60 ? 500 : 800;
  }
}
