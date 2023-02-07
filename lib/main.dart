import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:odac_flutter_app/screens/home/HomeScreen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:odac_flutter_app/ui/theme.dart';

Future main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]); // screen 세로 고정

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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

      // screen
      home: const HomeScreen(),
    );
  }
}
