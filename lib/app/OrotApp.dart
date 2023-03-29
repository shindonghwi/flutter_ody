import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:odac_flutter_app/presentation/features/splash/SplashScreen.dart';
import 'package:odac_flutter_app/presentation/navigation/Route.dart';
import 'package:odac_flutter_app/presentation/ui/theme.dart';

class OrotApp extends StatelessWidget {
  const OrotApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // app default option
      onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,

      // 시스템 테마 설정 (라이트, 다크 모드)
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,

      // 앱 Localization ( 영어, 한국어 지원 )
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,

      debugShowCheckedModeBanner: true,

      initialRoute: RoutingScreen.Splash.route,
      routes: RoutingScreen.getAppRoutes(),
    );
  }
}
