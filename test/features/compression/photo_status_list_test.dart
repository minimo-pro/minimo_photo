import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:minimo_photo/features/compression/bloc/compress_state.dart';
import 'package:minimo_photo/features/compression/domain/picked_photo.dart';
import 'package:minimo_photo/features/compression/presentation/widgets/photo_status_list.dart';
import 'package:minimo_photo/theme/app_colors.dart';

void main() {
  testWidgets('current photo shows right-aligned red progress', (tester) async {
    final state =
        CompressState.initial(const [
          PickedPhoto(path: '/photo.mp4', name: 'photo.mp4', size: 100),
        ]).copyWith(
          photoStatuses: const [PhotoCompressionStatus.processing],
          currentPhotoProgress: 0.42,
        );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: PhotoStatusList(state: state)),
      ),
    );

    expect(
      find.ancestor(
        of: find.byKey(const ValueKey('photo-status-processing')),
        matching: find.byType(ScaleTransition),
      ),
      findsNothing,
    );
    final indicator = tester.widget<SizedBox>(
      find.byKey(const ValueKey('photo-status-processing')),
    );
    final text = indicator.child! as Text;
    expect(text.data, '42%');
    expect(text.textAlign, TextAlign.right);
    expect(text.style?.color, CompressionUiColors.red);
  });
}
