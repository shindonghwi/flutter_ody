import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:odac_flutter_app/presentation/components/button/FillButton.dart';
import 'package:odac_flutter_app/presentation/components/button/model/ButtonNotifier.dart';
import 'package:odac_flutter_app/presentation/components/button/model/ButtonSizeType.dart';
import 'package:odac_flutter_app/presentation/components/button/model/ButtonState.dart';
import 'package:odac_flutter_app/presentation/navigation/PageMoveUtil.dart';
import 'package:odac_flutter_app/presentation/navigation/Route.dart';
import 'package:odac_flutter_app/presentation/ui/colors.dart';
import 'package:odac_flutter_app/presentation/ui/typography.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';

class WelcomeScreen extends HookWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getColorScheme(context).colorUI01,
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(45, 0, 45, 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              getAppLocalizations(context).welcome_title("운동하는 다람쥐"),
              style: getTextTheme(context).h4.copyWith(
                    color: getColorScheme(context).colorText,
                  ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 21),
            Text(
              getAppLocalizations(context).welcome_subtitle,
              style: getTextTheme(context).t3.copyWith(
                color: getColorScheme(context).neutral60,
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 76),
            Container(
              width: double.infinity,
              child: FillButton(
                borderRadius: 100,
                text: getAppLocalizations(context).welcome_button,
                type: ButtonSizeType.Normal,
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    nextSlideScreen(RoutingScreen.Home.route),
                  );
                },
                buttonProvider: StateNotifierProvider<ButtonNotifier, ButtonState>(
                  (_) => ButtonNotifier(state: ButtonState.Activated),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
