import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:minimo_photo/features/compression/bloc/compress_bloc.dart';
import 'package:minimo_photo/features/compression/bloc/compress_state.dart';
import 'package:minimo_photo/features/compression/domain/compression_result.dart';
import 'package:minimo_photo/features/compression/domain/picked_photo.dart';
import 'package:minimo_photo/features/compression/presentation/widgets/compression_result_view.dart';
import 'package:minimo_photo/generated/l10n.dart';
import 'package:minimo_photo/widgets/animated_asset_checkbox.dart';

void main() {
  testWidgets('replacement can be selected before Photos access is granted', (
    tester,
  ) async {
    const photo = PickedPhoto(
      path: '/missing-original.jpg',
      name: 'original.jpg',
      size: 100,
      sourceIdentifier: 'asset-1',
    );
    final bloc = CompressBloc();
    addTearDown(bloc.close);
    final state = bloc.state.copyWith(
      status: CompressStatus.done,
      photos: [photo],
      thumbnailPaths: [null],
      photoStatuses: [PhotoCompressionStatus.compressed],
      results: [
        CompressedPhoto(
          source: photo,
          result: CompressionResult(
            success: true,
            outputPath: '/tmp/compressed.jpg',
            originalSize: 100,
            outputSize: 50,
          ),
        ),
      ],
    );
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(platform: TargetPlatform.iOS),
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        home: BlocProvider.value(
          value: bloc,
          child: Scaffold(
            body: CompressionResultView(state: state, onTryAgain: () {}),
          ),
        ),
      ),
    );
    await tester.tap(find.text('save'));
    await tester.pumpAndSettle();
    final replace = find.byKey(
      const ValueKey('gallery-save-mode-replaceOriginal'),
    );
    await tester.tap(replace);
    await tester.pumpAndSettle();
    expect(
      tester
          .widget<AnimatedAssetCheckbox>(
            find.descendant(
              of: replace,
              matching: find.byType(AnimatedAssetCheckbox),
            ),
          )
          .value,
      isTrue,
    );
    Navigator.of(tester.element(replace)).pop();
    await tester.pumpAndSettle();
    await tester.pumpWidget(const SizedBox());
  });
}
