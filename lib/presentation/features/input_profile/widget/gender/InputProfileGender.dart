import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:odac_flutter_app/domain/models/me/GenderType.dart';
import 'package:odac_flutter_app/presentation/components/button/fill/FillButton.dart';
import 'package:odac_flutter_app/presentation/components/button/model/ButtonNotifier.dart';
import 'package:odac_flutter_app/presentation/components/button/model/ButtonSizeType.dart';
import 'package:odac_flutter_app/presentation/components/button/model/ButtonState.dart';
import 'package:odac_flutter_app/presentation/components/loading/CircleLoading.dart';
import 'package:odac_flutter_app/presentation/features/input_profile/notifier/ui/InputGenderUiStateNotifier.dart';
import 'package:odac_flutter_app/presentation/features/input_profile/provider/InputProfilePageViewController.dart';
import 'package:odac_flutter_app/presentation/features/input_profile/widget/gender/GenderSelector.dart';
import 'package:odac_flutter_app/presentation/models/UiState.dart';
import 'package:odac_flutter_app/presentation/ui/colors.dart';
import 'package:odac_flutter_app/presentation/ui/typography.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';
import 'package:odac_flutter_app/presentation/utils/snackbar/SnackBarUtil.dart';

class InputProfileGender extends HookConsumerWidget {
  const InputProfileGender({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(inputGenderUiStateProvider);
    final stateProvider = ref.read(inputGenderUiStateProvider.notifier);
    final pageController = ref.read(inputProfilePageViewControllerProvider);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        state.when(
          success: (event) async {
            pageController.nextPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
            stateProvider.resetState();
          },
          failure: (event) {
            SnackBarUtil.show(context, event.errorMessage);
          },
        );
      });
    }, [state]);

    final isSelectedMan = useState(true);

    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(35, 40, 35, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _title(context),
              const SizedBox(height: 24),
              GenderSelector(isSelectedMan: isSelectedMan),
              _NextButton(isSelectedMan: isSelectedMan.value)
            ],
          ),
        ),
        if (state is Loading) const CircleLoading(),
      ],
    );
  }

  /// 성별을 선택해주세요
  Widget _title(BuildContext context) {
    return Text(
      getAppLocalizations(context).input_profile_gender_title,
      style: getTextTheme(context).h4sb.copyWith(
            color: getColorScheme(context).colorText,
          ),
    );
  }
}

class _NextButton extends HookConsumerWidget {
  final isSelectedMan;

  const _NextButton({
    Key? key,
    required this.isSelectedMan,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uiStateProvider = ref.read(inputGenderUiStateProvider.notifier);

    return Expanded(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: FillButton(
            text: getAppLocalizations(context).common_next,
            type: ButtonSizeType.Normal,
            onPressed: () {
              uiStateProvider.patchGender(isSelectedMan ? GenderType.MALE : GenderType.FEMALE);
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
