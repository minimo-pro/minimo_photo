import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:minimo_photo/generated/l10n.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:upgrader/upgrader.dart';

void main() {
  for (final style in UpgradeDialogStyle.values) {
    testWidgets('upgrade dialog uses the app locale: $style', (tester) async {
      SharedPreferences.setMockInitialValues({});
      final upgrader = Upgrader(
        storeController: UpgraderStoreController(
          onAndroid: null,
          oniOS: null,
          onMacOS: null,
        ),
      );
      addTearDown(upgrader.dispose);
      await tester.pumpWidget(
        MaterialApp(
          locale: const Locale('ru'),
          localizationsDelegates: const [
            S.delegate,
            ...GlobalMaterialLocalizations.delegates,
          ],
          supportedLocales: S.delegate.supportedLocales,
          home: UpgradeAlert(
            upgrader: upgrader,
            dialogStyle: style,
            child: const Scaffold(),
          ),
        ),
      );
      await tester.pumpAndSettle();
      upgrader.updateState(
        upgrader.state.copyWith(
          debugDisplayOnce: true,
          versionInfo: UpgraderVersionInfo(),
        ),
      );
      await tester.pumpAndSettle();
      // UpgradeAlert schedules the dialog after the version check frame.
      await tester.pump(const Duration(milliseconds: 1));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      expect(find.text('Обновить?'), findsOneWidget);
    });
  }
}
