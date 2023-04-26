import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:odac_flutter_app/presentation/components/button/fill/FillButton.dart';
import 'package:odac_flutter_app/presentation/components/button/model/ButtonNotifier.dart';
import 'package:odac_flutter_app/presentation/components/button/model/ButtonSizeType.dart';
import 'package:odac_flutter_app/presentation/components/button/model/ButtonState.dart';
import 'package:odac_flutter_app/presentation/components/textfield/OutlineDefaultTextField.dart';
import 'package:odac_flutter_app/presentation/components/textfield/model/TextFieldModel.dart';
import 'package:odac_flutter_app/presentation/components/textfield/model/TextFieldState.dart';
import 'package:odac_flutter_app/presentation/features/input_profile/notifier/InputProfileWeightTextFieldNotifier.dart';
import 'package:odac_flutter_app/presentation/features/input_profile/provider/InputProfilePageViewController.dart';
import 'package:odac_flutter_app/presentation/features/input_profile/provider/InputProfileWeightTextFieldProvider.dart';
import 'package:odac_flutter_app/presentation/ui/colors.dart';
import 'package:odac_flutter_app/presentation/ui/typography.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';
import 'package:odac_flutter_app/presentation/utils/regex/TypeChecker.dart';

class InputProfileWeight extends HookConsumerWidget {
  final TextEditingController controller;

  const InputProfileWeight({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fieldState = ref.watch<TextFieldModel>(InputProfileWeightTextFieldProvider);
    final fieldStateRead = ref.read(InputProfileWeightTextFieldProvider.notifier);
    final pageController = ref.read(inputProfilePageViewControllerProvider);

    onCheckButtonAction() {
      if (fieldStateRead.checkWeight()) {
        FocusManager.instance.primaryFocus?.unfocus();
        pageController.nextPage(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      } else {
        final currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus && currentFocus.hasFocus) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      }
    }

    return Container(
      padding: const EdgeInsets.fromLTRB(35, 29, 35, 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Title(context),
          SizedBox(height: 30),
          _InputTextField(
            controller: controller,
            helpText: fieldState.helpMessage,
            fieldStateRead: fieldStateRead,
            fieldState: fieldState.fieldState,
            pageController: pageController,
            onCheckButtonAction: onCheckButtonAction,
          ),
          _NextButton(
            controller: pageController,
            fieldState: fieldState.fieldState,
            onCheckButtonAction: onCheckButtonAction,
          )
        ],
      ),
    );
  }

  /** 몸무게를 입력해주세요 */
  Widget _Title(BuildContext context) {
    return Text(
      getAppLocalizations(context).input_profile_weight_title,
      style: getTextTheme(context).h3sb.copyWith(
            color: getColorScheme(context).colorText,
          ),
    );
  }
}

class _InputTextField extends HookWidget {
  const _InputTextField({
    super.key,
    required this.controller,
    required this.helpText,
    required this.fieldStateRead,
    required this.fieldState,
    required this.pageController,
    required this.onCheckButtonAction,
  });

  final TextEditingController controller;
  final String? helpText;
  final InputProfileWeightTextFieldNotifier fieldStateRead;
  final TextFieldState fieldState;
  final PageController pageController;
  final VoidCallback onCheckButtonAction;

  @override
  Widget build(BuildContext context) {
    final minWeight = 30;
    final maxWeight = 200;

    return OutlineDefaultTextField(
      controller: controller,
      textInputType: TextInputType.datetime,
      textInputAction: TextInputAction.done,
      autoFocus: true,
      hint: getAppLocalizations(context).input_profile_weight_hint,
      onChanged: (String value) {
        fieldStateRead.updateWeight(value);
        fieldStateRead.change(fieldState: TextFieldState.Default, helpMessage: "");
        if (TypeChecker.isNumeric(value)) {
          int num = int.parse(value);
          if (num < minWeight || num > maxWeight) {
            fieldStateRead.change(
                fieldState: TextFieldState.Error,
                helpMessage: getAppLocalizations(context)
                    .input_profile_help_message_error_range(minWeight, maxWeight));
          } else {
            fieldStateRead.change(
                fieldState: TextFieldState.Focus,
                helpMessage: getAppLocalizations(context).input_profile_help_message_success);
          }
        } else if (value.length != 0) {
          fieldStateRead.change(fieldState: TextFieldState.Error);
        }
      },
      limit: 3,
      maxLine: 1,
      helpText: helpText,
      fieldState: fieldState,
      onDoneAction: () => onCheckButtonAction.call(),
    );
  }
}

class _NextButton extends HookWidget {
  final PageController controller;
  final TextFieldState fieldState;
  final VoidCallback onCheckButtonAction;

  const _NextButton({
    super.key,
    required this.controller,
    required this.fieldState,
    required this.onCheckButtonAction,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: FillButton(
            text: getAppLocalizations(context).common_next,
            type: ButtonSizeType.Small,
            onPressed: () => onCheckButtonAction.call(),
            buttonProvider: StateNotifierProvider<ButtonNotifier, ButtonState>(
              (_) => ButtonNotifier(
                state: fieldState == TextFieldState.Focus
                    ? ButtonState.Activated
                    : ButtonState.Disabled,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
