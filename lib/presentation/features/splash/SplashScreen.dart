import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:get_it/get_it.dart';
import 'package:odac_flutter_app/data/data_source/remote/Service.dart';
import 'package:odac_flutter_app/domain/models/auth/LoginPlatform.dart';
import 'package:odac_flutter_app/domain/models/auth/SocialLoginModel.dart';
import 'package:odac_flutter_app/domain/usecases/local/app/GetAppPolicyCheckUseCase.dart';
import 'package:odac_flutter_app/domain/usecases/remote/auth/PostSocialLoginUseCase.dart';
import 'package:odac_flutter_app/presentation/navigation/PageMoveUtil.dart';
import 'package:odac_flutter_app/presentation/navigation/Route.dart';
import 'package:odac_flutter_app/presentation/ui/colors.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';

final firebaseAuth = FirebaseAuth.instance;

class SplashScreen extends HookWidget {
  SocialLoginModel? socialInfo;

  final GetAppPolicyCheckUseCase _getAppPolicyCheckUseCase =
      GetIt.instance<GetAppPolicyCheckUseCase>();

  final PostSocialLoginInUseCase _postSocialLoginInUseCase =
      GetIt.instance<PostSocialLoginInUseCase>();

  SplashScreen({super.key});

  /// 소셜 로그인 정보를 확인한다.
  checkFirebaseUserSocialInfo(User? user) {
    if (user != null) {
      user.getIdToken().then((token) {
        List<UserInfo>? providers = user.providerData;
        for (UserInfo provider in providers) {
          LoginPlatform platform = getLoginPlatform(provider.providerId);
          socialInfo = SocialLoginModel(platform, token);
        }
      });
    } else {
      socialInfo = null;
    }
  }

  /// 로그인 플랫폼을 구분한다.
  LoginPlatform getLoginPlatform(String platform) {
    if (platform.contains("google")) {
      return LoginPlatform.Google;
    } else if (platform.contains("kakao")) {
      return LoginPlatform.Kakao;
    } else if (platform.contains("apple")) {
      return LoginPlatform.Apple;
    } else {
      return LoginPlatform.None;
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentContext = context;

    movePage(RoutingScreen screen) async {
      Navigator.pushReplacement(
        currentContext,
        nextSlideScreen(screen.route),
      );
    }

    FirebaseAuth.instance.authStateChanges().listen((user) {
      checkFirebaseUserSocialInfo(user);
    });

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
            if (socialInfo == null) {
              movePage(RoutingScreen.Login);
            } else {
              final res = await _postSocialLoginInUseCase.call(
                platform: socialInfo!.loginPlatform,
                accessToken: socialInfo?.accessToken ?? "",
              );

              if (res.status == 200) {
                Service.addHeader(
                  key: "Authorization",
                  value: res.data?.accessToken ?? "",
                );
                movePage(RoutingScreen.Main);
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
