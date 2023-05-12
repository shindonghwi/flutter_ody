import 'package:flutter/material.dart';
import 'package:odac_flutter_app/presentation/features/edit/my_height/EditMyHeightScreen.dart';
import 'package:odac_flutter_app/presentation/features/edit/my_info/EditMyInfoScreen.dart';
import 'package:odac_flutter_app/presentation/features/edit/my_nickname/EditMyNicknameScreen.dart';
import 'package:odac_flutter_app/presentation/features/edit/my_weight/EditMyWeightScreen.dart';
import 'package:odac_flutter_app/presentation/features/input_profile/InputProfileScreen.dart';
import 'package:odac_flutter_app/presentation/features/list/blood_pressure/RecordedListBloodPressureScreen.dart';
import 'package:odac_flutter_app/presentation/features/list/glucose/RecordedListGlucoseScreen.dart';
import 'package:odac_flutter_app/presentation/features/login/LoginScreen.dart';
import 'package:odac_flutter_app/presentation/features/main/MainScreen.dart';
import 'package:odac_flutter_app/presentation/features/onboarding/OnBoardingScreen.dart';
import 'package:odac_flutter_app/presentation/features/record/blood_pressure/RecordBloodPressureScreen.dart';
import 'package:odac_flutter_app/presentation/features/record/glucose/RecordGlucoseScreen.dart';
import 'package:odac_flutter_app/presentation/features/setting/SettingScreen.dart';
import 'package:odac_flutter_app/presentation/features/splash/SplashScreen.dart';
import 'package:odac_flutter_app/presentation/features/welcome/WelcomeScreen.dart';
import 'package:odac_flutter_app/presentation/features/withdrawal/WithdrawalReasonScreen.dart';
import 'package:odac_flutter_app/presentation/features/withdrawal/WithdrawalScreen.dart';
import 'package:odac_flutter_app/presentation/features/withdrawal/WithdrawalScreen.dart';
import 'package:odac_flutter_app/presentation/features/withdrawal/WithdrawalScreen.dart';

/// @feature: 화면의 Route Name 정의
///
/// @author: 2023/03/29 05:10 PM donghwishin
enum RoutingScreen {
  Splash(route: "/splash"), // 스플래시
  OnBoarding(route: "/onBoarding"), // 온보딩
  Login(route: "/login"), // 로그인
  InputProfile(route: "/input_profile"), // 사용자 정보 입력
  Welcome(route: "/welcome"), // 회원가입 완료화면
  Main(route: "/main"), // 메인화면
  RecordBloodPressure(route: "/record/blood_pressure"), // 혈압 기록
  RecordGlucose(route: "/record/glucose"), // 혈당 기록
  RecordedListBloodPressure(route: "/list/blood_pressure"), // 혈압 기록 목록
  RecordedListGlucose(route: "/list/glucose"), // 혈당 기록 목록
  EditMyInfo(route: "/edit/my_info"), // 내 정보 수정
  EditMyNickname(route: "/edit/my_nickname"), // 닉네임 수정
  EditMyHeight(route: "/edit/my_height"), // 키 수정
  EditMyWeight(route: "/edit/my_weight"), // 몸무게 수정
  Setting(route: "/setting"), // 설정화면
  Withdrawal(route: "/withdrawal"), // 회원탈퇴
  WithdrawalReason(route: "/withdrawal/reason"); // 회원탈퇴 사유

  final String route;

  const RoutingScreen({
    required this.route,
  });

  static Map<String, WidgetBuilder> getAppRoutes() {
    return {
      RoutingScreen.Splash.route: (context) => SplashScreen(),
      RoutingScreen.OnBoarding.route: (context) => OnBoardingScreen(),
      RoutingScreen.Login.route: (context) => const LoginScreen(),
      RoutingScreen.InputProfile.route: (context) => const InputProfileScreen(),
      RoutingScreen.Welcome.route: (context) => const WelcomeScreen(),
      RoutingScreen.Main.route: (context) => MainScreen(),
      RoutingScreen.RecordBloodPressure.route: (context) => const RecordBloodPressureScreen(),
      RoutingScreen.RecordGlucose.route: (context) => const RecordGlucoseScreen(),
      RoutingScreen.RecordedListBloodPressure.route: (context) => const RecordedListBloodPressureScreen(),
      RoutingScreen.RecordedListGlucose.route: (context) => const RecordedListGlucoseScreen(),
      RoutingScreen.EditMyInfo.route: (context) => const EditMyInfoScreen(),
      RoutingScreen.EditMyNickname.route: (context) => const EditMyNicknameScreen(),
      RoutingScreen.EditMyHeight.route: (context) => const EditMyHeightScreen(),
      RoutingScreen.EditMyWeight.route: (context) => const EditMyWeightScreen(),
      RoutingScreen.Setting.route: (context) => const SettingScreen(),
      RoutingScreen.Withdrawal.route: (context) => const WithdrawalScreen(),
      RoutingScreen.WithdrawalReason.route: (context) => const WithdrawalReasonScreen(),
    };
  }

  static getScreen(String route) {
    switch (route) {
      case "/splash":
        return SplashScreen();
      case "/onBoarding":
        return OnBoardingScreen();
      case "/login":
        return const LoginScreen();
      case "/input_profile":
        return const InputProfileScreen();
      case "/welcome":
        return const WelcomeScreen();
      case "/main":
        return MainScreen();
      case "/record/blood_pressure":
        return const RecordBloodPressureScreen();
      case "/record/glucose":
        return const RecordGlucoseScreen();
      case "/list/blood_pressure":
        return const RecordedListBloodPressureScreen();
      case "/list/glucose":
        return const RecordedListGlucoseScreen();
      case "/edit/my_info":
        return const EditMyInfoScreen();
      case "/edit/my_nickname":
        return const EditMyNicknameScreen();
      case "/edit/my_height":
        return const EditMyHeightScreen();
      case "/edit/my_weight":
        return const EditMyWeightScreen();
      case "/setting":
        return const SettingScreen();
      case "/withdrawal":
        return const WithdrawalScreen();
      case "/withdrawal/reason":
        return const WithdrawalReasonScreen();
      default:
        return const LoginScreen();
    }
  }
}
