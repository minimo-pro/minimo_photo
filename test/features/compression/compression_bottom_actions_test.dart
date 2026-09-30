import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:minimo_photo/features/compression/presentation/widgets/compression_bottom_actions.dart';
import 'package:minimo_photo/generated/l10n.dart';
import 'package:minimo_photo/widgets/app_action_button.dart';

void main() {
  testWidgets('add action is in the same row as compress', (tester) async {
    var addCalls = 0;
    var compressCalls = 0;

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        home: Scaffold(
          body: CompressionBottomActions(
            onAdd: () => addCalls++,
            onCompress: () => compressCalls++,
          ),
        ),
      ),
    );

    final actions = find.byType(AppActionButton);
    expect(actions, findsNWidgets(2));
    expect(
      tester.getTopLeft(actions.at(0)).dy,
      tester.getTopLeft(actions.at(1)).dy,
    );

    await tester.tap(actions.at(0));
    await tester.tap(find.text('compress'));

    expect(addCalls, 1);
    expect(compressCalls, 1);
  });

  testWidgets('compress is disabled without savings', (tester) async {
    var compressCalls = 0;

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        home: Scaffold(
          body: CompressionBottomActions(onAdd: () {}, onCompress: null),
        ),
      ),
    );

    await tester.tap(find.text('compress'));
    expect(compressCalls, 0);
  });

  testWidgets('import progress keeps both actions disabled', (tester) async {
    var compressCalls = 0;
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        home: Scaffold(
          body: CompressionBottomActions(
            onAdd: null,
            onCompress: () => compressCalls++,
            isImporting: true,
            importProgress: (1, 3),
          ),
        ),
      ),
    );

    expect(find.text('loading photos... 1 / 3'), findsOneWidget);
    await tester.tap(find.byType(AppActionButton).last);
    expect(compressCalls, 0);
  });
}
