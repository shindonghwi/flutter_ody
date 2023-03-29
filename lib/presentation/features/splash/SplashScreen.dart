import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:odac_flutter_app/presentation/navigation/PageMoveUtil.dart';
import 'package:odac_flutter_app/presentation/navigation/Route.dart';
import 'package:odac_flutter_app/presentation/ui/colors.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';

class SplashScreen extends HookWidget {
  moveOnBoardingPage(BuildContext context) {
    Timer(
      Duration(milliseconds: 1500),
      () => Navigator.pushReplacement(
        context,
        nextSlideScreen(RoutingScreen.OnBoarding.route),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    useEffect(() => moveOnBoardingPage(context), []);

    return Scaffold(
      backgroundColor: getColorScheme(context).colorBackground,
      body: Center(
        child: Image.asset("assets/imgs/logo_ody.png"),
      ),
    );
  }
}
