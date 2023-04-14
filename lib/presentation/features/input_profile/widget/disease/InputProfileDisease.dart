import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:odac_flutter_app/presentation/components/button/FillButton.dart';
import 'package:odac_flutter_app/presentation/components/button/model/ButtonNotifier.dart';
import 'package:odac_flutter_app/presentation/components/button/model/ButtonSizeType.dart';
import 'package:odac_flutter_app/presentation/components/button/model/ButtonState.dart';
import 'package:odac_flutter_app/presentation/features/input_profile/provider/DiseaseListStateProvider.dart';
import 'package:odac_flutter_app/presentation/features/input_profile/provider/InputProfilePageViewController.dart';
import 'package:odac_flutter_app/presentation/features/input_profile/widget/disease/DiseaseSelector.dart';
import 'package:odac_flutter_app/presentation/navigation/PageMoveUtil.dart';
import 'package:odac_flutter_app/presentation/navigation/Route.dart';
import 'package:odac_flutter_app/presentation/ui/colors.dart';
import 'package:odac_flutter_app/presentation/ui/typography.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';

class InputProfileDisease extends HookConsumerWidget {
  const InputProfileDisease({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageController = ref.read(inputProfilePageViewControllerProvider);

    return Container(
      padding: const EdgeInsets.fromLTRB(35, 29, 35, 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Title(context),
          SizedBox(height: 30),
          DiseaseSelector(),
          _SkipButton(controller: pageController)
        ],
      ),
    );
  }

  /** 관심있거나 ~~ 질환이 있나요? */
  Widget _Title(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          getAppLocalizations(context).input_profile_disease_title,
          style: getTextTheme(context).h3.copyWith(
                color: getColorScheme(context).colorText,
              ),
        ),
        SizedBox(height: 5),
        Text(
          getAppLocalizations(context).input_profile_disease_subtitle,
          style: getTextTheme(context).c1.copyWith(
                color: getColorScheme(context).neutral50,
              ),
        ),
      ],
    );
  }
}

class _SkipButton extends HookConsumerWidget {
  final PageController controller;

  const _SkipButton({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final diseaseActiveStateList = ref.watch<List<bool>>(diseaseListStateProvider);
    final diseaseListRead = ref.read(diseaseListStateProvider.notifier);

    return Expanded(
      child: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              getAppLocalizations(context).input_profile_disease_last_message,
              style: getTextTheme(context).c1.copyWith(
                    color: getColorScheme(context).neutral50,
                  ),
            ),
            SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: FillButton(
                text: getAppLocalizations(context).common_skip,
                type: ButtonSizeType.Small,
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    nextSlideScreen(RoutingScreen.Welcome.route),
                  );
                },
                buttonProvider: StateNotifierProvider<ButtonNotifier, ButtonState>(
                  (_) => ButtonNotifier(
                    state: diseaseListRead.hasTrue() ? ButtonState.Activated : ButtonState.Disabled,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
