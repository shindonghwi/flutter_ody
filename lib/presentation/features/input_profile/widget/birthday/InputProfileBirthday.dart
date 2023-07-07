import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ody_flutter_app/presentation/components/button/fill/FillButton.dart';
import 'package:ody_flutter_app/presentation/components/button/model/ButtonNotifier.dart';
import 'package:ody_flutter_app/presentation/components/button/model/ButtonSizeType.dart';
import 'package:ody_flutter_app/presentation/components/button/model/ButtonState.dart';
import 'package:ody_flutter_app/presentation/components/loading/CircleLoading.dart';
import 'package:ody_flutter_app/presentation/components/textfield/OutlineDefaultTextField.dart';
import 'package:ody_flutter_app/presentation/components/textfield/model/TextFieldModel.dart';
import 'package:ody_flutter_app/presentation/components/textfield/model/TextFieldState.dart';
import 'package:ody_flutter_app/presentation/components/toast/Toast.dart';
import 'package:ody_flutter_app/presentation/features/input_profile/notifier/textfield/InputProfileBirthdayTextFieldNotifier.dart';
import 'package:ody_flutter_app/presentation/features/input_profile/notifier/ui/InputBirthdayUiStateNotifier.dart';
import 'package:ody_flutter_app/presentation/features/input_profile/provider/InputProfilePageViewController.dart';
import 'package:ody_flutter_app/presentation/models/UiState.dart';
import 'package:ody_flutter_app/presentation/ui/colors.dart';
import 'package:ody_flutter_app/presentation/ui/typography.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';
import 'package:ody_flutter_app/presentation/utils/regex/DateFormatterKoreaBirthday.dart';

class InputProfileBirthday extends HookConsumerWidget {
  final TextEditingController controller;

  const InputProfileBirthday({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uiState = ref.watch(inputBirthdayUiStateProvider);
    final birthdayUiStateProvider = ref.read(inputBirthdayUiStateProvider.notifier);
    final pageController = ref.read(inputProfilePageViewControllerProvider);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        uiState.when(
          success: (event) async {
            pageController.nextPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
            birthdayUiStateProvider.resetState();
          },
          failure: (event) {
            ToastUtil.errorToast(context, event.errorMessage);
          },
        );
      });
    }, [uiState]);

    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(35, 40, 35, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _title(context),
              const SizedBox(height: 24),
              _InputTextField(controller: controller),
              const _NextButton(),
            ],
          ),
        ),
        if (uiState is Loading) const CircleLoading()
      ],
    );
  }

  /// 생년월일을 선택해주세요
  Widget _title(BuildContext context) {
    return Text(
      getAppLocalizations(context).input_profile_birthday_title,
      style: getTextTheme(context).h4sb.copyWith(
            color: getColorScheme(context).colorText,
          ),
    );
  }
}

class _InputTextField extends HookConsumerWidget {
  final TextEditingController controller;

  const _InputTextField({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fieldState = ref.watch<TextFieldModel>(inputProfileBirthdayTextFieldProvider);
    final fieldStateRead = ref.read(inputProfileBirthdayTextFieldProvider.notifier);
    final birthdayUiStateProvider = ref.read(inputBirthdayUiStateProvider.notifier);

    onCheckButtonAction() {
      if (fieldStateRead.checkBirthday()) {
        birthdayUiStateProvider.patchBirthday(fieldStateRead.content.replaceAll("/", "-"));
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
      hint: getAppLocalizations(context).input_profile_birthday_hint,
      inputFormatters: [
        DateFormatterKoreaBirthday(),
      ],
      onChanged: (String value) {
        fieldStateRead.updateBirthday(value);
        fieldStateRead.change(helpMessage: "");
        if (value.length == 10) {
          fieldStateRead.change(
            fieldState: TextFieldState.Focus,
            helpMessage: getAppLocalizations(context).input_profile_help_message_success,
          );
        } else if (value.isEmpty) {
          fieldStateRead.change(fieldState: TextFieldState.Default);
        } else {
          fieldStateRead.change(
            fieldState: TextFieldState.Error,
            helpMessage: getAppLocalizations(context).input_profile_help_message_error_retry,
          );
        }
      },
      limit: 10,
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
    final fieldState = ref.watch<TextFieldModel>(inputProfileBirthdayTextFieldProvider);
    final fieldStateRead = ref.read(inputProfileBirthdayTextFieldProvider.notifier);
    final birthdayUiStateProvider = ref.read(inputBirthdayUiStateProvider.notifier);

    onCheckButtonAction() {
      if (fieldStateRead.checkBirthday()) {
        birthdayUiStateProvider.patchBirthday(fieldStateRead.content.replaceAll("/", "-"));
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
                state: fieldState.fieldState == TextFieldState.Focus ? ButtonState.Activated : ButtonState.Disabled,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
