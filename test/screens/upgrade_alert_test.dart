import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:minimo_photo/generated/l10n.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:upgrader/upgrader.dart';

void main() {
  for (final style in UpgradeDialogStyle.values) {
    testWidgets('upgrade dialog uses existing Flutter localization: $style', (
      tester,
    ) async {
      SharedPreferences.setMockInitialValues({});
      final key = GlobalKey<UpgradeAlertState>();
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: const [
            S.delegate,
            ...GlobalMaterialLocalizations.delegates,
          ],
          supportedLocales: S.delegate.supportedLocales,
          home: UpgradeAlert(
            key: key,
            upgrader: Upgrader(
              storeController: UpgraderStoreController(
                onAndroid: null,
                oniOS: null,
                onMacOS: null,
              ),
            ),
            dialogStyle: style,
            child: const Scaffold(),
          ),
        ),
      );
      await tester.pump();
      key.currentState!.showTheDialog(
        context: key.currentContext!,
        title: 'Update available',
        message: 'A new version is available.',
        releaseNotes: null,
        barrierDismissible: true,
        messages: UpgraderMessages(code: 'en'),
      );
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      expect(find.text('Update available'), findsOneWidget);
    });
  }
}
