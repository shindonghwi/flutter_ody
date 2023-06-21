import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ody_flutter_app/presentation/navigation/Route.dart';
import 'package:ody_flutter_app/presentation/ui/theme.dart';

final googleSignIn = Platform.isAndroid
    ? GoogleSignIn(
  scopes: ['email', 'profile'],
)
    : GoogleSignIn(
  scopes: ['email', 'profile'],
);

final firebaseAuth = FirebaseAuth.instance;

class OrotApp extends StatelessWidget {
  const OrotApp({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth != 0) {
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

            navigatorKey: OdyGlobalVariable.naviagatorState,
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

class OdyGlobalVariable {
  static final GlobalKey<NavigatorState> naviagatorState = GlobalKey<NavigatorState>();
}
