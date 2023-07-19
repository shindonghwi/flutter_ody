import 'package:flutter/material.dart';
import 'package:ody_flutter_app/data/models/bio/ResponseBioBloodPressureModel.dart';
import 'package:ody_flutter_app/data/models/bio/ResponseBioGlucoseModel.dart';
import 'package:ody_flutter_app/presentation/features/analysis/blood_pressure/AnalysisBloodPressureScreen.dart';
import 'package:ody_flutter_app/presentation/features/analysis/glucose/AnalysisGlucoseScreen.dart';
import 'package:ody_flutter_app/presentation/features/edit/my_height/EditMyHeightScreen.dart';
import 'package:ody_flutter_app/presentation/features/edit/my_info/EditMyInfoScreen.dart';
import 'package:ody_flutter_app/presentation/features/edit/my_nickname/EditMyNicknameScreen.dart';
import 'package:ody_flutter_app/presentation/features/edit/my_weight/EditMyWeightScreen.dart';
import 'package:ody_flutter_app/presentation/features/input_profile/InputProfileScreen.dart';
import 'package:ody_flutter_app/presentation/features/list/blood_pressure/RecordedListBloodPressureScreen.dart';
import 'package:ody_flutter_app/presentation/features/list/glucose/RecordedListGlucoseScreen.dart';
import 'package:ody_flutter_app/presentation/features/list/medication/MedicationListScreen.dart';
import 'package:ody_flutter_app/presentation/features/list/report_monthly/ReportMonthlyListScreen.dart';
import 'package:ody_flutter_app/presentation/features/list/report_weekly/ReportWeeklyListScreen.dart';
import 'package:ody_flutter_app/presentation/features/login/LoginScreen.dart';
import 'package:ody_flutter_app/presentation/features/main/MainScreen.dart';
import 'package:ody_flutter_app/presentation/features/onboarding/OnBoardingScreen.dart';
import 'package:ody_flutter_app/presentation/features/record/blood_pressure/RecordBloodPressureScreen.dart';
import 'package:ody_flutter_app/presentation/features/record/glucose/RecordGlucoseScreen.dart';
import 'package:ody_flutter_app/presentation/features/report/monthly/ReportMonthlyScreen.dart';
import 'package:ody_flutter_app/presentation/features/report/weekly/ReportWeeklyScreen.dart';
import 'package:ody_flutter_app/presentation/features/setting/SettingScreen.dart';
import 'package:ody_flutter_app/presentation/features/setting/alarm/SettingAlarmScreen.dart';
import 'package:ody_flutter_app/presentation/features/setting/medication/AddMedicationScreen.dart';
import 'package:ody_flutter_app/presentation/features/splash/SplashScreen.dart';
import 'package:ody_flutter_app/presentation/features/welcome/WelcomeScreen.dart';
import 'package:ody_flutter_app/presentation/features/withdrawal/WithdrawalReasonScreen.dart';
import 'package:ody_flutter_app/presentation/features/withdrawal/WithdrawalScreen.dart';

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
  MainHome(route: "/main/home"), // 메인 - 홈(나의기록)
  MainAnalysis(route: "/main/analysis"), // 메인 - 분석하기
  MainMyInfo(route: "/main/my_info"), // 메인 - 내정보

  RecordBloodPressure(route: "/record/blood_pressure"), // 혈압 기록
  RecordGlucose(route: "/record/glucose"), // 혈당 기록

  AnalysisBloodPressure(route: "/analysis/blood_pressure"), // 혈압 분석
  AnalysisGlucose(route: "/analysis/glucose"), // 혈당 분석

  RecordedListBloodPressure(route: "/list/blood_pressure"), // 혈압 기록 목록
  RecordedListGlucose(route: "/list/glucose"), // 혈당 기록 목록
  ReportWeeklyList(route: "/list/report/weekly"), // 주간 보고서 목록
  ReportMonthlyList(route: "/list/report/monthly"), // 월간 보고서 목록
  MedicationList(route: "/list/medication"), // 약 알림 리스트

  ReportWeekly(route: "/report/weekly"), // 주간 보고서
  ReportMonthly(route: "/report/monthly"), // 월간 보고서

  EditMyInfo(route: "/edit/my_info"), // 내 정보 수정
  EditMyNickname(route: "/edit/my_nickname"), // 닉네임 수정
  EditMyHeight(route: "/edit/my_height"), // 키 수정
  EditMyWeight(route: "/edit/my_weight"), // 몸무게 수정
  Setting(route: "/setting"), // 설정화면
  SettingAlarm(route: "/setting/alarm"), // 알림 설정화면
  AddMedication(route: "/setting/add/medication"), // 약 알림 추가화면
  Withdrawal(route: "/withdrawal"), // 회원탈퇴
  WithdrawalReason(route: "/withdrawal/reason"), // 회원탈퇴 사유


  // 화면 이동 X
  ServerError(route: "/error"); // 서버 에러 콘텐츠

  final String route;

  const RoutingScreen({
    required this.route,
  });

  static Map<String, WidgetBuilder> getAppRoutes() {
    return {
      RoutingScreen.Splash.route: (context) => SplashScreen(),
      RoutingScreen.OnBoarding.route: (context) => const OnBoardingScreen(),
      RoutingScreen.Login.route: (context) => const LoginScreen(),
      RoutingScreen.InputProfile.route: (context) => const InputProfileScreen(),
      RoutingScreen.Welcome.route: (context) => const WelcomeScreen(),
      RoutingScreen.Main.route: (context) => MainScreen(),
      RoutingScreen.RecordBloodPressure.route: (context) => const RecordBloodPressureScreen(),
      RoutingScreen.RecordGlucose.route: (context) => const RecordGlucoseScreen(),
      RoutingScreen.AnalysisBloodPressure.route: (context) => const AnalysisBloodPressureScreen(),
      RoutingScreen.AnalysisGlucose.route: (context) => const AnalysisGlucoseScreen(),
      RoutingScreen.RecordedListBloodPressure.route: (context) => const RecordedListBloodPressureScreen(),
      RoutingScreen.RecordedListGlucose.route: (context) => const RecordedListGlucoseScreen(),
      RoutingScreen.ReportWeeklyList.route: (context) => const ReportWeeklyListScreen(),
      RoutingScreen.ReportMonthlyList.route: (context) => const ReportMonthlyListScreen(),
      RoutingScreen.MedicationList.route: (context) => const MedicationListScreen(),
      RoutingScreen.ReportWeekly.route: (context) => const ReportWeeklyScreen(),
      RoutingScreen.ReportMonthly.route: (context) => const ReportMonthlyScreen(),
      RoutingScreen.EditMyInfo.route: (context) => const EditMyInfoScreen(),
      RoutingScreen.EditMyNickname.route: (context) => const EditMyNicknameScreen(),
      RoutingScreen.EditMyHeight.route: (context) => const EditMyHeightScreen(),
      RoutingScreen.EditMyWeight.route: (context) => const EditMyWeightScreen(),
      RoutingScreen.Setting.route: (context) => const SettingScreen(),
      RoutingScreen.SettingAlarm.route: (context) => const SettingAlarmScreen(),
      RoutingScreen.AddMedication.route: (context) => const AddMedicationScreen(),
      RoutingScreen.Withdrawal.route: (context) => const WithdrawalScreen(),
      RoutingScreen.WithdrawalReason.route: (context) => const WithdrawalReasonScreen(),
    };
  }

  static getScreen(String route, {dynamic parameter}) {
    switch (route) {
      case "/splash":
        return SplashScreen();
      case "/onBoarding":
        return const OnBoardingScreen();
      case "/login":
        return const LoginScreen();
      case "/input_profile":
        int initPageNumber = parameter ?? 0;
        return InputProfileScreen(initPageNumber: initPageNumber);
      case "/welcome":
        return const WelcomeScreen();
      case "/main":
        return MainScreen();
      case "/record/blood_pressure":
        return const RecordBloodPressureScreen();
      case "/record/glucose":
        return const RecordGlucoseScreen();
      case "/report/weekly":
        int? reportSeq = parameter;
        return ReportWeeklyScreen(reportSeq: reportSeq);
      case "/report/monthly":
        int? reportSeq = parameter;
        return ReportMonthlyScreen(reportSeq: reportSeq);
      case "/analysis/blood_pressure":
        List<ResponseBioBloodPressureModel>? bpList = parameter;
        return AnalysisBloodPressureScreen(bpList: bpList);
      case "/analysis/glucose":
        List<ResponseBioGlucoseModel>? glucoseList = parameter;
        return AnalysisGlucoseScreen(glucoseList: glucoseList);
      case "/list/blood_pressure":
        return const RecordedListBloodPressureScreen();
      case "/list/glucose":
        return const RecordedListGlucoseScreen();
      case "/list/report/weekly":
        return const ReportWeeklyListScreen();
      case "/list/report/monthly":
        return const ReportMonthlyListScreen();
      case "/list/medication":
        return const MedicationListScreen();
      case "/edit/my_info":
        return const EditMyInfoScreen();
      case "/edit/my_nickname":
        String nick = parameter;
        return EditMyNicknameScreen(nick: nick);
      case "/edit/my_height":
        int height = int.parse(parameter);
        return EditMyHeightScreen(height: height);
      case "/edit/my_weight":
        int weight = int.parse(parameter);
        return EditMyWeightScreen(weight: weight);
      case "/setting":
        return const SettingScreen();
      case "/setting/alarm":
        return const SettingAlarmScreen();
      case "/setting/add/medication":
        return const AddMedicationScreen();
      case "/withdrawal":
        return const WithdrawalScreen();
      case "/withdrawal/reason":
        return const WithdrawalReasonScreen();
      default:
        return const LoginScreen();
    }
  }
}
