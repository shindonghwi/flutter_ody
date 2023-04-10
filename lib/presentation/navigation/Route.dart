import 'package:flutter/material.dart';
import 'package:odac_flutter_app/presentation/features/input_profile/InputProfileScreen.dart';
import 'package:odac_flutter_app/presentation/features/login/LoginScreen.dart';
import 'package:odac_flutter_app/presentation/features/onboarding/OnBoardingScreen.dart';
import 'package:odac_flutter_app/presentation/features/splash/SplashScreen.dart';

/**
 * @feature: 화면의 Route Name 정의
 *
 * @author: 2023/03/29 05:10 PM donghwishin
 */
enum RoutingScreen {
  Splash(route: "/splash"), // 스플래시
  OnBoarding(route: "/onBoarding"), // 온보딩
  Login(route: "/login"), // 로그인
  InputProfile(route: "/input_profile"); // 사용자 정보 입력

  final String route;

  const RoutingScreen({
    required this.route,
  });

  static Map<String, WidgetBuilder> getAppRoutes() {
    return {
      RoutingScreen.Splash.route: (context) => SplashScreen(),
      RoutingScreen.OnBoarding.route: (context) => OnBoardingScreen(),
      RoutingScreen.Login.route: (context) => LoginScreen(),
      RoutingScreen.InputProfile.route: (context) => InputProfileScreen(),
    };
  }

  static getScreen(String route) {
    switch (route) {
      case "/splash":
        return SplashScreen();
      case "/onBoarding":
        return OnBoardingScreen();
      case "/login":
        return LoginScreen();
      case "/input_profile":
        return InputProfileScreen();
      default:
        return LoginScreen();
    }
  }
}
