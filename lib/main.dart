import 'package:material_ui/material_ui.dart';

import 'generated/l10n.dart';
import 'router/app_router.dart';
import 'services/app_cache_service.dart';
import 'services/app_settings_service.dart';
import 'theme/app_theme.dart';

final _appRouter = AppRouter();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppSettingsService.instance.load();
  await AppCacheService.clear().onError((_, _) {});
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: AppSettingsService.instance,
      builder: (context, _) => MaterialApp.router(
        debugShowCheckedModeBanner: false,
        locale: AppSettingsService.instance.locale,
        onGenerateTitle: (context) => S.of(context).appName,
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: AppSettingsService.instance.themeMode,
        localizationsDelegates: const [
          S.delegate,
          ...GlobalMaterialLocalizations.delegates,
        ],
        supportedLocales: S.delegate.supportedLocales,
        routerConfig: _appRouter.config(),
        builder: (context, child) {
          // rate_my_app and stupid_simple_sheet still read Theme and
          // MaterialLocalizations from package:flutter/material.dart.
          // ignore: deprecated_member_use
          return MaterialUiCompatibilityBridge(child: child!);
        },
      ),
    );
  }
}
