import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:odac_flutter_app/data/data_source/remote/Service.dart';
import 'package:odac_flutter_app/domain/models/auth/SocialLoginModel.dart';
import 'package:odac_flutter_app/domain/usecases/local/app/GetAppPolicyCheckUseCase.dart';
import 'package:odac_flutter_app/domain/usecases/remote/auth/PostSocialLoginUseCase.dart';
import 'package:odac_flutter_app/presentation/features/splash/notifier/SocialAccessTokenCheckNotifier.dart';
import 'package:odac_flutter_app/presentation/navigation/PageMoveUtil.dart';
import 'package:odac_flutter_app/presentation/navigation/Route.dart';
import 'package:odac_flutter_app/presentation/ui/colors.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';

class SplashScreen extends HookConsumerWidget {
  final GetAppPolicyCheckUseCase _getAppPolicyCheckUseCase =
      GetIt.instance<GetAppPolicyCheckUseCase>();

  final PostSocialLoginInUseCase _postSocialLoginInUseCase =
      GetIt.instance<PostSocialLoginInUseCase>();

  SplashScreen({super.key});

  moveOnBoardingPage(BuildContext context) {
    Timer(
      const Duration(milliseconds: 1000),
      () => Navigator.pushReplacement(
        context,
        nextSlideScreen(RoutingScreen.OnBoarding.route),
      ),
    );
  }

  moveMainPage(BuildContext context) {
    Timer(
      const Duration(milliseconds: 1000),
      () => Navigator.pushReplacement(
        context,
        nextSlideScreen(RoutingScreen.Login.route),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentContext = context;
    final socialAccessTokenProvider = ref.read(socialAccessTokenCheckProvider.notifier);
    SocialLoginModel? socialInfo;

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
        socialInfo = await socialAccessTokenProvider.hasAccessToken();

        _getAppPolicyCheckUseCase.call().then((granted) async {
          if (granted) {
            if (socialInfo == null) {
              moveOnBoardingPage(context);
            } else {

              // 로그인 요청
              final res = await _postSocialLoginInUseCase.call(
                platform: socialInfo!.loginPlatform,
                accessToken: socialInfo?.accessToken ?? "",
              );

              if (res.status == 200) {
                Service.addHeader(key: "Authorization", value: res.data?.accessToken ?? "");
                Navigator.pushReplacement(
                  currentContext,
                  nextSlideScreen(RoutingScreen.Main.route),
                );
              }else{
                Navigator.pushReplacement(
                  currentContext,
                  nextSlideScreen(RoutingScreen.Login.route),
                );
              }
            }
          } else {
            moveOnBoardingPage(context);
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
