import 'package:flutter/material.dart';
import 'package:odac_flutter_app/presentation/features/input_profile/InputProfileScreen.dart';
import 'package:odac_flutter_app/presentation/features/login/LoginScreen.dart';
import 'package:odac_flutter_app/presentation/features/main/MainScreen.dart';
import 'package:odac_flutter_app/presentation/features/onboarding/OnBoardingScreen.dart';
import 'package:odac_flutter_app/presentation/features/record/blood_pressure/RecordBloodPressureScreen.dart';
import 'package:odac_flutter_app/presentation/features/record/glucose/RecordGlucoseScreen.dart';
import 'package:odac_flutter_app/presentation/features/splash/SplashScreen.dart';
import 'package:odac_flutter_app/presentation/features/welcome/WelcomeScreen.dart';


/**
 * @feature: 화면의 Route Name 정의
 *
 * @author: 2023/03/29 05:10 PM donghwishin
 */
enum RoutingScreen {
  Splash(route: "/splash"), // 스플래시
  OnBoarding(route: "/onBoarding"), // 온보딩
  Login(route: "/login"), // 로그인
  InputProfile(route: "/input_profile"), // 사용자 정보 입력
  Welcome(route: "/welcome"), // 회원가입 완료화면
  Main(route: "/main"), // 메인화면
  RecordBloodPressure(route: "/record/blood_pressure"), // 혈압 기록
  RecordGlucose(route: "/record/glucose"); // 혈당 기록

  final String route;

  const RoutingScreen({
    required this.route,
  });

  static Map<String, WidgetBuilder> getAppRoutes() {
    return {
      RoutingScreen.Splash.route: (context) => MainScreen(),
      RoutingScreen.OnBoarding.route: (context) => OnBoardingScreen(),
      RoutingScreen.Login.route: (context) => LoginScreen(),
      RoutingScreen.InputProfile.route: (context) => InputProfileScreen(),
      RoutingScreen.Welcome.route: (context) => WelcomeScreen(),
      RoutingScreen.Main.route: (context) => MainScreen(),
      RoutingScreen.RecordBloodPressure.route: (context) => RecordBloodPressureScreen(),
      RoutingScreen.RecordGlucose.route: (context) => RecordGlucoseScreen(),
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
      case "/welcome":
        return WelcomeScreen();
      case "/main":
        return MainScreen();
      case "/record/blood_pressure":
        return RecordBloodPressureScreen();
      case "/record/glucose":
        return RecordGlucoseScreen();
      default:
        return LoginScreen();
    }
  }
}
