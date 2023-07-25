import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ody_flutter_app/app/env/Environment.dart';
import 'package:ody_flutter_app/firebase/FirebaseCloudMessage.dart';
import 'package:ody_flutter_app/presentation/navigation/Route.dart';
import 'package:ody_flutter_app/presentation/ui/colors.dart';
import 'package:ody_flutter_app/presentation/ui/theme.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';

final googleSignIn = Platform.isAndroid
    ? GoogleSignIn(
        scopes: ['email', 'profile'],
      )
    : GoogleSignIn(
        scopes: ['email', 'profile'],
      );

final firebaseAuth = FirebaseAuth.instance;

class OrotApp extends HookWidget {
  const OrotApp({super.key});

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await Environment.setLocalNotification();
        await FirebaseCloudMessage.initFCM();
      });
      return null;
    }, []);

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth != 0) {
          return MaterialApp(
            // app default option
            onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,

            // 시스템 테마 설정 (라이트, 다크 모드)
            theme: AppTheme.lightTheme.copyWith(
              textSelectionTheme: TextSelectionThemeData(
                cursorColor: getColorScheme(context).colorPrimaryFocus,
              ),
            ),
            darkTheme: AppTheme.darkTheme.copyWith(
              textSelectionTheme: TextSelectionThemeData(
                cursorColor: getColorScheme(context).colorPrimaryFocus,
              ),
            ),
            themeMode: ThemeMode.system,

            // 앱 Localization ( 영어, 한국어 지원 )
            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: AppLocalizations.localizationsDelegates,

            debugShowCheckedModeBanner: true,

            initialRoute: RoutingScreen.Splash.route,
            routes: RoutingScreen.getAppRoutes(),

            navigatorKey: OdyGlobalVariable.navigatorKey,
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
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}
