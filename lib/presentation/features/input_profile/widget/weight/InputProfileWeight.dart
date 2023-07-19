import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ody_flutter_app/presentation/components/button/fill/FillButton.dart';
import 'package:ody_flutter_app/presentation/components/button/model/ButtonNotifier.dart';
import 'package:ody_flutter_app/presentation/components/button/model/ButtonSizeType.dart';
import 'package:ody_flutter_app/presentation/components/button/model/ButtonState.dart';
import 'package:ody_flutter_app/presentation/components/loading/CircleLoading.dart';
import 'package:ody_flutter_app/presentation/components/textfield/InputTextField.dart';
import 'package:ody_flutter_app/presentation/components/toast/Toast.dart';
import 'package:ody_flutter_app/presentation/features/input_profile/notifier/ui/InputWeightUiStateNotifier.dart';
import 'package:ody_flutter_app/presentation/features/input_profile/provider/InputProfilePageViewController.dart';
import 'package:ody_flutter_app/presentation/features/main/my/provider/meInfoProvider.dart';
import 'package:ody_flutter_app/presentation/models/UiState.dart';
import 'package:ody_flutter_app/presentation/ui/colors.dart';
import 'package:ody_flutter_app/presentation/ui/typography.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';
import 'package:ody_flutter_app/presentation/utils/regex/FixedInputFormatter.dart';

class InputProfileWeight extends HookConsumerWidget {
  const InputProfileWeight({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isButtonActive = useState<bool>(false);

    void onChanged(bool flag) => isButtonActive.value = flag;

    final meInfoRead = ref.read(meInfoProvider.notifier);
    final uiState = ref.watch(inputWeightUiStateProvider);
    final uiStateRead = ref.read(inputWeightUiStateProvider.notifier);
    final pageController = ref.read(inputProfilePageViewControllerProvider);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        uiState.when(
          success: (event) async {
            meInfoRead.updateMeInfoWeight(uiStateRead.weight);
            uiStateRead.resetState();
            pageController.nextPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          },
          failure: (event) {
            ToastUtil.errorToast(event.errorMessage);
          },
        );
      });
      return null;
    }, [uiState]);

    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(35, 29, 35, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _title(context),
              const SizedBox(height: 24),
              _InputTextField(onChanged: onChanged),
              _NextButton(isButtonActive: isButtonActive.value),
            ],
          ),
        ),
        if (uiState is Loading) const CircleLoading()
      ],
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
  final Function(bool flag) onChanged;

  const _InputTextField({
    super.key,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final meInfoRead = ref.read(meInfoProvider.notifier);
    final weightRead = ref.read(inputWeightUiStateProvider.notifier);
    final pattern = RegExp(r'^(3[0-6]|[3-9]\d|1\d\d|200)$'); // 30 <= x <= 200
    const fixedContent = "kg";

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (weightRead.weight != 0) {
          final weight = weightRead.weight.toString();
          onChanged(pattern.hasMatch(weight.toString()));
          weightRead.updateWeight(int.tryParse(weight) ?? 0);
        }
        if (meInfoRead.getMeProfile()?.birthday != null) {
          final weight = meInfoRead.getMeProfile()!.weight.toString();
          onChanged(pattern.hasMatch(weight));
          weightRead.updateWeight(int.tryParse(weight) ?? 0);
        }
      });
      return null;
    }, []);

    return InputTextField(
      autoFocus: true,
      initText: weightRead.weight != 0
          ? weightRead.weight.toString()
          : meInfoRead.getMeProfile()!.weight == 0
          ? ""
          : meInfoRead.getMeProfile()!.weight.toString(),
      hint: getAppLocalizations(context).input_profile_weight_hint,
      textInputAction: TextInputAction.next,
      textInputType: TextInputType.number,
      limit: 3 + fixedContent.length,
      onChanged: (String value) {
        onChanged(pattern.hasMatch(value));
        weightRead.updateWeight(int.tryParse(value) ?? 0);
      },
      successMessage: getAppLocalizations(context).input_profile_message_success,
      errorMessage: getAppLocalizations(context).input_profile_message_error,
      fixedContent: fixedContent,
      showCounter: true,
      regList: [pattern],
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        FixedInputFormatter(suffix: fixedContent),
      ],
    );
  }
}

class _NextButton extends HookConsumerWidget {
  final bool isButtonActive;

  const _NextButton({
    super.key,
    required this.isButtonActive,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weightRead = ref.read(inputWeightUiStateProvider.notifier);

    return Expanded(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: FillButton(
            text: getAppLocalizations(context).common_next,
            type: ButtonSizeType.Normal,
            onPressed: () => weightRead.patchWeight(),
            buttonProvider: StateNotifierProvider<ButtonNotifier, ButtonState>(
              (_) => ButtonNotifier(
                state: isButtonActive ? ButtonState.Activated : ButtonState.Disabled,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
