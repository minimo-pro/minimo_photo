import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:minimo_photo/features/compression/presentation/widgets/selected_photos_preview.dart';
import 'package:minimo_photo/theme/app_theme.dart';

void main() {
  testWidgets('preview border stays white in light mode', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light,
        home: const SelectedPhotosPreview(
          selectedCount: 1,
          thumbnailPaths: [null],
        ),
      ),
    );

    final container = tester
        .widgetList<Container>(find.byType(Container))
        .firstWhere((widget) => widget.foregroundDecoration is BoxDecoration);
    final decoration = container.foregroundDecoration! as BoxDecoration;
    expect((decoration.border! as Border).top.color, Colors.white);
  });

  testWidgets('selected count badge stays inside preview top edge', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: SelectedPhotosPreview(
          selectedCount: 2,
          thumbnailPaths: [null, null],
        ),
      ),
    );

    final previewTop = tester.getTopLeft(find.byType(SelectedPhotosPreview)).dy;
    final badgeTop = tester.getTopLeft(find.widgetWithText(Container, '2')).dy;

    expect(badgeTop, greaterThanOrEqualTo(previewTop));
  });

  testWidgets('three-digit count stays on one line inside badge', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: SelectedPhotosPreview(
          selectedCount: 104,
          thumbnailPaths: [null, null, null],
        ),
      ),
    );

    final badge = find.widgetWithText(Container, '104');
    final count = find.text('104');
    final paragraph = tester.renderObject<RenderParagraph>(count);

    expect(
      paragraph.getBoxesForSelection(
        const TextSelection(baseOffset: 0, extentOffset: 3),
      ),
      hasLength(1),
    );
    expect(
      tester.getRect(badge).contains(tester.getRect(count).center),
      isTrue,
    );
  });
}
