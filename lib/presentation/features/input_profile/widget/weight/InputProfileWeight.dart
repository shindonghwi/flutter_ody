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
import 'package:odac_flutter_app/presentation/features/input_profile/notifier/textfield/InputProfileWeightTextFieldNotifier.dart';
import 'package:odac_flutter_app/presentation/features/input_profile/notifier/ui/InputWeightUiStateNotifier.dart';
import 'package:odac_flutter_app/presentation/features/input_profile/provider/InputProfilePageViewController.dart';
import 'package:odac_flutter_app/presentation/ui/colors.dart';
import 'package:odac_flutter_app/presentation/ui/typography.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';
import 'package:odac_flutter_app/presentation/utils/regex/TypeChecker.dart';
import 'package:odac_flutter_app/presentation/utils/snackbar/SnackBarUtil.dart';

class InputProfileWeight extends HookConsumerWidget {
  final TextEditingController controller;

  const InputProfileWeight({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uiState = ref.watch(inputWeightUiStateProvider);
    final weightUiStateProvider = ref.read(inputWeightUiStateProvider.notifier);
    final pageController = ref.read(inputProfilePageViewControllerProvider);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        uiState.when(
          success: (event) async {
            pageController.nextPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
            weightUiStateProvider.resetState();
          },
          failure: (event) {
            SnackBarUtil.show(context, event.errorMessage);
          },
        );
      });
    }, [uiState]);

    return Container(
      padding: const EdgeInsets.fromLTRB(35, 29, 35, 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _title(context),
          const SizedBox(height: 24),
          _InputTextField(controller: controller),
          const _NextButton()
        ],
      ),
    );
  }

  /// 몸무게를 입력해주세요
  Widget _title(BuildContext context) {
    return Text(
      getAppLocalizations(context).input_profile_weight_title,
      style: getTextTheme(context).h4sb.copyWith(
            color: getColorScheme(context).colorText,
          ),
    );
  }
}

class _InputTextField extends HookConsumerWidget {
  const _InputTextField({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fieldState = ref.watch<TextFieldModel>(inputProfileWeightTextFieldProvider);
    final fieldStateRead = ref.read(inputProfileWeightTextFieldProvider.notifier);
    final weightUiStateProvider = ref.read(inputWeightUiStateProvider.notifier);

    const minWeight = 30;
    const maxWeight = 200;

    onCheckButtonAction() {
      if (fieldStateRead.checkWeight()) {
        weightUiStateProvider.patchWeight(int.parse(fieldStateRead.content));
      } else {
        final currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus && currentFocus.hasFocus) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      }
    }

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
                helpMessage:
                    getAppLocalizations(context).input_profile_help_message_success);
          }
        } else if (value.isNotEmpty) {
          fieldStateRead.change(fieldState: TextFieldState.Error);
        }
      },
      limit: 3,
      maxLine: 1,
      helpText: fieldState.helpMessage,
      fieldState: fieldState.fieldState,
      onDoneAction: () => onCheckButtonAction.call(),
    );
  }
}

class _NextButton extends HookConsumerWidget {
  const _NextButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fieldState = ref.watch<TextFieldModel>(inputProfileWeightTextFieldProvider);
    final fieldStateRead = ref.read(inputProfileWeightTextFieldProvider.notifier);
    final weightUiStateProvider = ref.read(inputWeightUiStateProvider.notifier);

    onCheckButtonAction() {
      if (fieldStateRead.checkWeight()) {
        weightUiStateProvider.patchWeight(int.parse(fieldStateRead.content));
      } else {
        final currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus && currentFocus.hasFocus) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      }
    }

    return Expanded(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              getAppLocalizations(context).input_profile_disease_next_last_message,
              style: getTextTheme(context).c1r.copyWith(
                color: getColorScheme(context).neutral60,
              ),
            ),
            const SizedBox(height: 24),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: FillButton(
                text: getAppLocalizations(context).common_next,
                type: ButtonSizeType.Normal,
                onPressed: () => onCheckButtonAction.call(),
                buttonProvider: StateNotifierProvider<ButtonNotifier, ButtonState>(
                      (_) => ButtonNotifier(
                    state: fieldState.fieldState == TextFieldState.Focus
                        ? ButtonState.Activated
                        : ButtonState.Disabled,
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
