import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimo_photo/features/compression/bloc/compress_bloc.dart';
import 'package:minimo_photo/features/compression/bloc/compress_state.dart';
import 'package:minimo_photo/features/compression/data/photo_compressor_adapter.dart';
import 'package:minimo_photo/features/compression/domain/compression_settings.dart';
import 'package:minimo_photo/features/compression/domain/picked_photo.dart';
import 'package:minimo_photo/features/compression/presentation/widgets/compression_mode_switch.dart';
import 'package:minimo_photo/features/compression/presentation/widgets/compression_settings_view.dart';
import 'package:minimo_photo/generated/l10n.dart';

void main() {
  testWidgets('mode switch exposes selected state', (tester) async {
    var mode = CompressionOptionsMode.simple;

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        home: StatefulBuilder(
          builder: (context, setState) => MediaQuery(
            data: MediaQuery.of(context).copyWith(disableAnimations: true),
            child: CompressionModeSwitch(
              value: mode,
              onChanged: (value) => setState(() => mode = value),
            ),
          ),
        ),
      ),
    );

    expect(_selectedModes(tester), [true, false]);
    await tester.tap(find.text('advanced'));
    await tester.pump();
    expect(_selectedModes(tester), [false, true]);
  });

  testWidgets('compact settings switch modes without overflow', (tester) async {
    final bloc = CompressBloc(
      initialPhotos: const [
        PickedPhoto(path: 'photo.jpg', name: 'photo.jpg', size: 1000),
      ],
      photoCompressorAdapter: _FakePhotoCompressorAdapter(),
    );
    addTearDown(bloc.close);

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        home: BlocProvider.value(
          value: bloc,
          child: Scaffold(
            body: SizedBox(
              height: 600,
              child: BlocBuilder<CompressBloc, CompressState>(
                builder: (context, state) =>
                    CompressionSettingsView(state: state, onAddPhotos: () {}),
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pump();

    expect(tester.takeException(), isNull);
    await tester.tap(find.text('advanced'));
    await tester.pumpAndSettle();
    expect(find.text('maximum dimension'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}

List<bool> _selectedModes(WidgetTester tester) => tester
    .widgetList<Semantics>(find.byType(Semantics))
    .where((widget) => widget.properties.button == true)
    .map((widget) => widget.properties.selected ?? false)
    .toList();

class _FakePhotoCompressorAdapter extends PhotoCompressorAdapter {
  @override
  Future<String?> createThumbnail(String inputPath) async => null;

  @override
  Future<int?> estimateCompressedSize(
    Iterable<String> inputPaths,
    CompressionSettings settings,
  ) async => 500;
}
