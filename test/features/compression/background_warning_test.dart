import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:minimo_photo/features/compression/bloc/compress_state.dart';
import 'package:minimo_photo/features/compression/domain/picked_photo.dart';
import 'package:minimo_photo/features/compression/presentation/widgets/compression_progress_view.dart';
import 'package:minimo_photo/generated/l10n.dart';

void main() {
  testWidgets('keep-open warning appears only without a background grant', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(430, 1000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final state = CompressState.initial(const [
      PickedPhoto(path: '/photo.jpg', name: 'photo.jpg', size: 100),
    ]).copyWith(status: CompressStatus.processing);

    for (final granted in [false, true]) {
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: const [
            S.delegate,
            ...GlobalMaterialLocalizations.delegates,
          ],
          supportedLocales: S.delegate.supportedLocales,
          home: Scaffold(
            body: CompressionProgressView(
              state: state.copyWith(canCompressInBackground: granted),
            ),
          ),
        ),
      );
      await tester.pump();
      expect(
        find.text(S.current.backgroundCompressionWarning),
        granted ? findsNothing : findsOneWidget,
      );
      expect(tester.takeException(), isNull);
    }
  });
}
