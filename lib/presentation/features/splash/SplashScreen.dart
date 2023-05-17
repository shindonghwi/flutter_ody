import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:get_it/get_it.dart';
import 'package:odac_flutter_app/data/data_source/remote/Service.dart';
import 'package:odac_flutter_app/domain/usecases/local/app/GetAppPolicyCheckUseCase.dart';
import 'package:odac_flutter_app/presentation/navigation/PageMoveUtil.dart';
import 'package:odac_flutter_app/presentation/navigation/Route.dart';
import 'package:odac_flutter_app/presentation/ui/colors.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';

class SplashScreen extends HookWidget {
  final GetAppPolicyCheckUseCase _getAppPolicyCheckUseCase =
      GetIt.instance<GetAppPolicyCheckUseCase>();

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
  Widget build(BuildContext context) {

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async{
        final String timeZone = await FlutterNativeTimezone.getLocalTimezone();
        final languageCode = WidgetsBinding.instance.window.locale.languageCode;
        final countryCode = WidgetsBinding.instance.window.locale.countryCode.toString();
        Service.setHeader(languageCode: languageCode, countryCode: countryCode, timeZone: timeZone);
      });
    }, []);

    useEffect(() {
      _getAppPolicyCheckUseCase.call().then((value) {
        if (value.status == 200 && value.data == true) {
          moveMainPage(context);
        } else {
          moveOnBoardingPage(context);
        }
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
