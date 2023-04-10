import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:odac_flutter_app/presentation/components/button/FillButton.dart';
import 'package:odac_flutter_app/presentation/components/button/model/ButtonNotifier.dart';
import 'package:odac_flutter_app/presentation/components/button/model/ButtonSizeType.dart';
import 'package:odac_flutter_app/presentation/components/button/model/ButtonState.dart';
import 'package:odac_flutter_app/presentation/features/input_profile/provider/InputProfilePageViewController.dart';
import 'package:odac_flutter_app/presentation/features/input_profile/widget/gender/GenderSelector.dart';
import 'package:odac_flutter_app/presentation/ui/colors.dart';
import 'package:odac_flutter_app/presentation/ui/typography.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';

class InputProfileGender extends HookConsumerWidget {
  const InputProfileGender({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSelectedMan = useState(true);
    final pageController = ref.read(inputProfilePageViewControllerProvider);

    return Container(
      padding: const EdgeInsets.fromLTRB(35, 49, 35, 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Title(context),
          SizedBox(height: 30),
          GenderSelector(isSelectedMan: isSelectedMan),
          _NextButton(context, pageController)
        ],
      ),
    );
  }

  /** 성별을 선택해주세요 */
  Widget _Title(BuildContext context) {
    return Text(
      getAppLocalizations(context).input_profile_gender_title,
      style: getTextTheme(context).h3.copyWith(
            color: getColorScheme(context).colorText,
          ),
    );
  }

  /** 다음 버튼 */
  Expanded _NextButton(BuildContext context, PageController pageController) {
    return Expanded(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: double.infinity,
          child: FillButton(
            text: getAppLocalizations(context).common_next,
            type: ButtonSizeType.Small,
            onPressed: () {
              pageController.nextPage(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
            buttonProvider: StateNotifierProvider<ButtonNotifier, ButtonState>(
              (_) => ButtonNotifier(
                state: ButtonState.Default,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
