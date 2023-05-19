import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:odac_flutter_app/app/OrotApp.dart';
import 'package:odac_flutter_app/data/data_source/remote/Service.dart';
import 'package:odac_flutter_app/data/models/me/ResponseMeInfoProfileModel.dart';
import 'package:odac_flutter_app/domain/models/auth/LoginPlatform.dart';
import 'package:odac_flutter_app/domain/models/auth/SocialLoginModel.dart';
import 'package:odac_flutter_app/domain/usecases/local/app/GetAppPolicyCheckUseCase.dart';
import 'package:odac_flutter_app/domain/usecases/remote/auth/PostSocialLoginUseCase.dart';
import 'package:odac_flutter_app/domain/usecases/remote/me/GetMeInfoUseCase.dart';
import 'package:odac_flutter_app/presentation/navigation/PageMoveUtil.dart';
import 'package:odac_flutter_app/presentation/navigation/Route.dart';
import 'package:odac_flutter_app/presentation/ui/colors.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';

class SplashScreen extends HookWidget {
  final GetAppPolicyCheckUseCase _getAppPolicyCheckUseCase =
      GetIt.instance<GetAppPolicyCheckUseCase>();

  final PostSocialLoginInUseCase _postSocialLoginInUseCase =
      GetIt.instance<PostSocialLoginInUseCase>();

  GetMeInfoUseCase get getMeInfoUseCase => GetIt.instance<GetMeInfoUseCase>();

  SplashScreen({super.key});

  Future<String?> getSocialAccessToken(String platform) async {
    final String platformName = platform.toLowerCase();
    if (platformName.contains("google")) {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signInSilently();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        return googleAuth.idToken;
      }
    } else if (platformName.contains("kakao")) {
      return null;
    } else if (platformName.contains("apple")) {
      return null;
    }
    return null;
  }

  /// 소셜 로그인 정보를 확인한다.
  Future<SocialLoginModel?> checkFirebaseUserSocialInfo() async {
    User? user = firebaseAuth.currentUser;

    if (user != null) {
      List<UserInfo>? providers = user.providerData;
      for (UserInfo provider in providers) {
        LoginPlatform platform = getLoginPlatform(provider.providerId);
        String? accessToken = await getSocialAccessToken(platform.name);
        debugPrint("accessToken: $accessToken");
        if (accessToken != null) {
          return SocialLoginModel(platform, accessToken);
        }
      }
    }

    return null;
  }

  /// 로그인 플랫폼을 구분한다.
  LoginPlatform getLoginPlatform(String platform) {
    final String platformName = platform.toLowerCase();

    if (platformName.contains("google")) {
      return LoginPlatform.Google;
    } else if (platformName.contains("kakao")) {
      return LoginPlatform.Kakao;
    } else if (platformName.contains("apple")) {
      return LoginPlatform.Apple;
    } else {
      return LoginPlatform.None;
    }
  }

  setServiceHeader(String? token) async {
    final String timeZone = await FlutterNativeTimezone.getLocalTimezone();
    final languageCode = WidgetsBinding.instance.window.locale.languageCode;
    final countryCode = WidgetsBinding.instance.window.locale.countryCode.toString();

    Service.setHeader(
      languageCode: languageCode,
      countryCode: countryCode,
      timeZone: timeZone,
      token: token ?? "",
    );
  }

  /// 회원가입 완료 여부 체크
  bool checkSignUpComplete(ResponseMeInfoProfileModel? profile) {
    if (profile == null) return false;

    final profileData = profile.toJson();

    return profileData["gender"] != null &&
        profileData["birthday"] != null &&
        (profileData["height"] as double?) != null &&
        profileData["height"] != 0 &&
        (profileData["weight"] as double?) != null &&
        profileData["weight"] != 0;
  }

  @override
  Widget build(BuildContext context) {
    SocialLoginModel? socialInfo;
    final currentContext = context;

    movePage(RoutingScreen screen) async {
      Navigator.pushReplacement(
        currentContext,
        nextSlideScreen(screen.route),
      );
    }

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        final String timeZone = await FlutterNativeTimezone.getLocalTimezone();
        final languageCode = WidgetsBinding.instance.window.locale.languageCode;
        final countryCode = WidgetsBinding.instance.window.locale.countryCode.toString();
        Service.setHeader(
          languageCode: languageCode,
          countryCode: countryCode,
          timeZone: timeZone,
        );

        _getAppPolicyCheckUseCase.call().then((granted) async {
          if (granted) {
            socialInfo = await checkFirebaseUserSocialInfo();
            if (socialInfo == null) {
              movePage(RoutingScreen.Login);
            } else {
              final res = await _postSocialLoginInUseCase.call(
                platform: socialInfo!.loginPlatform,
                accessToken: socialInfo?.accessToken ?? "",
              );

              if (res.status == 200) {
                // 내 정보 요청
                await setServiceHeader(res.data?.accessToken);
                await getMeInfoUseCase.call().then((value) {
                  if (value.status == 200) {
                    if (checkSignUpComplete(value.data?.profile)) {
                      // 여기서 사용자 정보 저장하고 메인으로 넘어가야함.
                      movePage(RoutingScreen.Main);
                    } else {
                      movePage(RoutingScreen.InputProfile);
                    }
                  } else {
                    movePage(RoutingScreen.Login);
                  }
                });
              } else {
                movePage(RoutingScreen.Login);
              }
            }
          } else {
            movePage(RoutingScreen.OnBoarding);
          }
        });
      });
    }, []);

    return Scaffold(
      backgroundColor: getColorScheme(context).colorUIBackground,
      body: Center(
        child: Image.asset("assets/imgs/logo_ody.png"),
      ),
    );
  }
}
