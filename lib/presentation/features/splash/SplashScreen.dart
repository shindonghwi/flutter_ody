import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ody_flutter_app/app/OrotApp.dart';
import 'package:ody_flutter_app/data/data_source/remote/Service.dart';
import 'package:ody_flutter_app/data/models/me/ResponseMeProfileModel.dart';
import 'package:ody_flutter_app/domain/models/auth/LoginPlatform.dart';
import 'package:ody_flutter_app/domain/models/auth/SocialLoginModel.dart';
import 'package:ody_flutter_app/domain/usecases/local/app/GetAppPolicyCheckUseCase.dart';
import 'package:ody_flutter_app/domain/usecases/remote/auth/PostSocialLoginUseCase.dart';
import 'package:ody_flutter_app/domain/usecases/remote/me/GetMeInfoUseCase.dart';
import 'package:ody_flutter_app/firebase/FirebaseRemoteConfigService.dart';
import 'package:ody_flutter_app/presentation/features/constant/constants.dart';
import 'package:ody_flutter_app/presentation/features/main/my/provider/meInfoProvider.dart';
import 'package:ody_flutter_app/presentation/navigation/PageMoveUtil.dart';
import 'package:ody_flutter_app/presentation/navigation/Route.dart';
import 'package:ody_flutter_app/presentation/ui/colors.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';

class SplashScreen extends HookConsumerWidget {
  final GetAppPolicyCheckUseCase _getAppPolicyCheckUseCase = GetIt.instance<GetAppPolicyCheckUseCase>();

  final PostSocialLoginInUseCase _postSocialLoginInUseCase = GetIt.instance<PostSocialLoginInUseCase>();

  GetMeInfoUseCase get getMeInfoUseCase => GetIt.instance<GetMeInfoUseCase>();

  SplashScreen({super.key});

  Future<String?> getSocialAccessToken(String platform) async {
    final String platformName = platform.toLowerCase();
    if (platformName.contains("google")) {
      final GoogleSignInAccount? googleUser = await googleSignIn.signInSilently();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        return googleAuth.idToken;
      }
    } else if (platformName.contains("kakao")) {
      return null;
    } else if (platformName.contains("apple")) {
      final user = FirebaseAuth.instance.currentUser;
      debugPrint("user : $user");
      if (user != null) {
        final idTokenResult = await user.getIdTokenResult(true);
        return idTokenResult.token;
      }
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
        debugPrint("provider.providerId : ${provider.providerId}");
        LoginPlatform platform = getLoginPlatform(provider.providerId);
        String? accessToken = await getSocialAccessToken(platform.name);
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
  int getSignUpProceedPage(ResponseMeProfileModel? profile) {
    if (profile == null) return 0;

    final profileData = profile.toJson();
    if (profileData["gender"] == null) return 0;
    if (profileData["birthday"] == null) return 1;
    if ((profileData["height"] as int?) == null || profileData["height"] == 0) return 2;
    if ((profileData["weight"] as int?) == null || profileData["weight"] == 0) return 3;

    return SIGN_UP_PROCEED_COMPLETE;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SocialLoginModel? socialInfo;
    final meInfoRead = ref.read(meInfoProvider.notifier);
    final currentContext = context;

    movePage(RoutingScreen screen, {int initPageNumber = 0}) async {
      Future.delayed(const Duration(milliseconds: 700), () async {
        Navigator.pushReplacement(
          currentContext,
          nextSlideScreen(screen.route, parameter: initPageNumber),
        );
      });
    }

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await FirebaseRemoteConfigService().initialize();
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
                    if (value.data != null) {
                      meInfoRead.updateMeInfo(value.data!);
                    }

                    final currentProceedPage = getSignUpProceedPage(value.data?.profile);
                    if (currentProceedPage == SIGN_UP_PROCEED_COMPLETE) {
                      movePage(RoutingScreen.Main);
                    } else {
                      movePage(
                        RoutingScreen.InputProfile,
                        initPageNumber: currentProceedPage,
                      );
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
      return null;
    }, []);

    return Scaffold(
      backgroundColor: getColorScheme(context).colorUIBackground,
      body: Center(
        child: Image.asset("assets/imgs/logo_splash.png"),
      ),
    );
  }
}
