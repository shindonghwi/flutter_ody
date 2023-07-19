import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ody_flutter_app/presentation/components/button/fill/FillButton.dart';
import 'package:ody_flutter_app/presentation/components/button/model/ButtonNotifier.dart';
import 'package:ody_flutter_app/presentation/components/button/model/ButtonSizeType.dart';
import 'package:ody_flutter_app/presentation/components/button/model/ButtonState.dart';
import 'package:ody_flutter_app/presentation/features/cache/UserCache.dart';
import 'package:ody_flutter_app/presentation/features/input_profile/notifier/InputProfileDiseaseSelectNotifier.dart';
import 'package:ody_flutter_app/presentation/features/input_profile/notifier/ui/InputBirthdayUiStateNotifier.dart';
import 'package:ody_flutter_app/presentation/features/input_profile/notifier/ui/InputDiseaseUiStateNotifier.dart';
import 'package:ody_flutter_app/presentation/features/input_profile/notifier/ui/InputHeightUiStateNotifier.dart';
import 'package:ody_flutter_app/presentation/features/input_profile/notifier/ui/InputWeightUiStateNotifier.dart';
import 'package:ody_flutter_app/presentation/navigation/PageMoveUtil.dart';
import 'package:ody_flutter_app/presentation/navigation/Route.dart';
import 'package:ody_flutter_app/presentation/ui/colors.dart';
import 'package:ody_flutter_app/presentation/ui/typography.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';

class WelcomeScreen extends HookConsumerWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(inputBirthdayUiStateProvider.notifier).clearData();
        ref.read(inputHeightUiStateProvider.notifier).clearData();
        ref.read(inputWeightUiStateProvider.notifier).clearData();
        ref.read(diseaseListStateProvider.notifier).clearData();
      });
      return null;
    },[]);

    return Scaffold(
      backgroundColor: getColorScheme(context).colorUI01,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.only(bottom: 29),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 80),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  getAppLocalizations(context).welcome_title("${userCache.userInfo?.nick}"),
                  style: getTextTheme(context).h3b.copyWith(
                        color: getColorScheme(context).colorText,
                        height: 1.28,
                      ),
                  maxLines: 3,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 32),
              Text(
                getAppLocalizations(context).welcome_subtitle,
                style: getTextTheme(context).t3m.copyWith(
                      color: getColorScheme(context).neutral70,
                    ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 65),
                  child: Center(
                    child: Image.asset(
                      "assets/imgs/welcome_image.png",
                    ),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 40),
                child: FillButton(
                  borderRadius: 100,
                  text: getAppLocalizations(context).welcome_button,
                  type: ButtonSizeType.Normal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      nextFadeInOutScreen(RoutingScreen.Main.route),
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
      ),
    );
  }
}
