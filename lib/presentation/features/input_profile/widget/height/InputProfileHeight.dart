import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:odac_flutter_app/presentation/components/button/FillButton.dart';
import 'package:odac_flutter_app/presentation/components/button/model/ButtonNotifier.dart';
import 'package:odac_flutter_app/presentation/components/button/model/ButtonSizeType.dart';
import 'package:odac_flutter_app/presentation/components/button/model/ButtonState.dart';
import 'package:odac_flutter_app/presentation/components/textfield/OutlineTextField.dart';
import 'package:odac_flutter_app/presentation/components/textfield/model/TextFieldState.dart';
import 'package:odac_flutter_app/presentation/features/input_profile/provider/InputProfilePageViewController.dart';
import 'package:odac_flutter_app/presentation/ui/colors.dart';
import 'package:odac_flutter_app/presentation/ui/typography.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';
import 'package:odac_flutter_app/presentation/utils/regex/TypeChecker.dart';

class InputProfileHeight extends HookConsumerWidget {
  const InputProfileHeight({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ValueNotifier<String?>? helpText = useState(null);
    final ValueNotifier<TextFieldState> fieldState = useState(TextFieldState.Default);
    final pageController = ref.read(inputProfilePageViewControllerProvider);

    return Container(
      padding: const EdgeInsets.fromLTRB(35, 29, 35, 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Title(context),
          SizedBox(height: 30),
          OutlineTextField(
            hint: getAppLocalizations(context).input_profile_height_hint,
            onChanged: (String value) {
              helpText?.value = '';
              fieldState.value = TextFieldState.Default;
              if (TypeChecker.isNumeric(value)) {
                int num = int.parse(value);
                if (num < 120 || num > 230) {
                  fieldState.value = TextFieldState.Error;
                  helpText?.value =
                      getAppLocalizations(context).input_profile_help_message_error_range(120, 230);
                } else {
                  fieldState.value = TextFieldState.Success;
                  helpText?.value = getAppLocalizations(context).input_profile_help_message_success;
                }
              } else if (value.length != 0) {
                helpText?.value =
                    getAppLocalizations(context).input_profile_help_message_error_retry;
                fieldState.value = TextFieldState.Error;
              }
            },
            limit: 3,
            maxLine: 1,
            helpText: helpText,
            fieldState: fieldState,
          ),
          _NextButton(context, pageController)
        ],
      ),
    );
  }

  /** 키를 입력해주세요 */
  Widget _Title(BuildContext context) {
    return Text(
      getAppLocalizations(context).input_profile_height_title,
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
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: FillButton(
            text: getAppLocalizations(context).common_next,
            type: ButtonSizeType.Small,
            onPressed: () {
              FocusManager.instance.primaryFocus?.unfocus();
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
