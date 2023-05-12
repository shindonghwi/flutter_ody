import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';
import 'package:odac_flutter_app/domain/usecases/app/GetAppPolicyCheckUseCase.dart';
import 'package:odac_flutter_app/domain/usecases/app/GetAppPolicyUpdateUseCase.dart';
import 'package:odac_flutter_app/presentation/navigation/PageMoveUtil.dart';
import 'package:odac_flutter_app/presentation/navigation/Route.dart';
import 'package:odac_flutter_app/presentation/ui/colors.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';

class SplashScreen extends HookWidget {

  final GetAppPolicyCheckUseCase _getAppPolicyCheckUseCase = GetIt.instance<GetAppPolicyCheckUseCase>();

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
        nextSlideScreen(RoutingScreen.Main.route),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    useEffect(() {
      _getAppPolicyCheckUseCase.call().then((value) {
        if (value){
          moveMainPage(context);
        }else{
          moveOnBoardingPage(context);
        }
      });
    },[]);

    return Scaffold(
      backgroundColor: getColorScheme(context).colorUIBackground,
      body: Center(
        child: Image.asset("assets/imgs/logo_ody.png"),
      ),
    );
  }
}
