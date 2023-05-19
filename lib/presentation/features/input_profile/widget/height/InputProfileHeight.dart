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
import 'package:odac_flutter_app/presentation/features/input_profile/notifier/textfield/InputProfileHeightTextFieldNotifier.dart';
import 'package:odac_flutter_app/presentation/features/input_profile/notifier/ui/InputHeightUiStateNotifier.dart';
import 'package:odac_flutter_app/presentation/features/input_profile/provider/InputProfilePageViewController.dart';
import 'package:odac_flutter_app/presentation/ui/colors.dart';
import 'package:odac_flutter_app/presentation/ui/typography.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';
import 'package:odac_flutter_app/presentation/utils/regex/TypeChecker.dart';
import 'package:odac_flutter_app/presentation/utils/snackbar/SnackBarUtil.dart';

class InputProfileHeight extends HookConsumerWidget {
  final TextEditingController controller;

  const InputProfileHeight({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uiState = ref.watch(inputHeightUiStateProvider);
    final heightUiStateProvider = ref.read(inputHeightUiStateProvider.notifier);
    final pageController = ref.read(inputProfilePageViewControllerProvider);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        uiState.when(
          success: (event) async {
            pageController.nextPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
            heightUiStateProvider.resetState();
          },
          failure: (event) {
            SnackBarUtil.show(context, event.errorMessage);
          },
        );
      });
    }, [uiState]);

    return Container(
      padding: const EdgeInsets.fromLTRB(35, 40, 35, 24),
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

  /// 키를 입력해주세요
  Widget _title(BuildContext context) {
    return Text(
      getAppLocalizations(context).input_profile_height_title,
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
    final fieldState = ref.watch<TextFieldModel>(inputProfileHeightTextFieldProvider);
    final fieldStateRead = ref.read(inputProfileHeightTextFieldProvider.notifier);
    final heightUiStateProvider = ref.read(inputHeightUiStateProvider.notifier);

    const minHeight = 120;
    const maxHeight = 230;

    onCheckButtonAction() {
      if (fieldStateRead.checkHeight()) {
        heightUiStateProvider.patchHeight(int.parse(fieldStateRead.content));
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
      textInputAction: TextInputAction.next,
      autoFocus: true,
      hint: getAppLocalizations(context).input_profile_height_hint,
      onChanged: (String value) {
        fieldStateRead.updateHeight(value);
        fieldStateRead.change(fieldState: TextFieldState.Default, helpMessage: "");
        if (TypeChecker.isNumeric(value)) {
          int num = int.parse(value);
          if (num < minHeight || num > maxHeight) {
            fieldStateRead.change(
              fieldState: TextFieldState.Error,
              helpMessage: getAppLocalizations(context)
                  .input_profile_help_message_error_range(minHeight, maxHeight),
            );
          } else {
            fieldStateRead.change(
              fieldState: TextFieldState.Focus,
              helpMessage:
                  getAppLocalizations(context).input_profile_help_message_success,
            );
          }
        } else if (value.isNotEmpty) {
          fieldStateRead.change(
            fieldState: TextFieldState.Error,
            helpMessage:
                getAppLocalizations(context).input_profile_help_message_error_retry,
          );
        }
      },
      limit: 3,
      maxLine: 1,
      helpText: fieldState.helpMessage,
      fieldState: fieldState.fieldState,
      onNextAction: () => onCheckButtonAction.call(),
    );
  }
}

class _NextButton extends HookConsumerWidget {
  const _NextButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fieldState = ref.watch<TextFieldModel>(inputProfileHeightTextFieldProvider);
    final fieldStateRead = ref.read(inputProfileHeightTextFieldProvider.notifier);
    final heightUiStateProvider = ref.read(inputHeightUiStateProvider.notifier);

    onCheckButtonAction() {
      if (fieldStateRead.checkHeight()) {
        heightUiStateProvider.patchHeight(int.parse(fieldStateRead.content));
      } else {
        final currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus && currentFocus.hasFocus) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      }
    }

    return Expanded(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
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
      ),
    );
  }
}
