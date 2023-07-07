import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ody_flutter_app/domain/models/me/DiseaseType.dart';
import 'package:ody_flutter_app/presentation/components/button/fill/FillButton.dart';
import 'package:ody_flutter_app/presentation/components/button/model/ButtonNotifier.dart';
import 'package:ody_flutter_app/presentation/components/button/model/ButtonSizeType.dart';
import 'package:ody_flutter_app/presentation/components/button/model/ButtonState.dart';
import 'package:ody_flutter_app/presentation/features/input_profile/notifier/InputProfileDiseaseSelectNotifier.dart';
import 'package:ody_flutter_app/presentation/features/input_profile/notifier/ui/InputDiseaseUiStateNotifier.dart';
import 'package:ody_flutter_app/presentation/features/input_profile/widget/disease/DiseaseSelector.dart';
import 'package:ody_flutter_app/presentation/navigation/PageMoveUtil.dart';
import 'package:ody_flutter_app/presentation/navigation/Route.dart';
import 'package:ody_flutter_app/presentation/ui/colors.dart';
import 'package:ody_flutter_app/presentation/ui/typography.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';
import 'package:ody_flutter_app/presentation/utils/snackbar/SnackBarUtil.dart';

class InputProfileDisease extends HookConsumerWidget {
  const InputProfileDisease({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(inputDiseaseUiStateProvider);
    final stateProvider = ref.read(inputDiseaseUiStateProvider.notifier);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        FocusScope.of(context).unfocus();
        state.when(
          success: (event) async {
            Navigator.pushReplacement(
              context,
              nextSlideScreen(RoutingScreen.Welcome.route),
            );
            stateProvider.resetState();
          },
          failure: (event) {
            SnackBarUtil.show(context, event.errorMessage);
          },
        );
      });
    }, [state]);

    return Container(
      padding: const EdgeInsets.fromLTRB(35, 40, 35, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _title(context),
          const SizedBox(height: 24),
          const DiseaseSelector(),
          const _SkipButton(),
        ],
      ),
    );
  }

  /// 관심있거나 ~~ 질환이 있나요?
  Widget _title(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          getAppLocalizations(context).input_profile_disease_title,
          style: getTextTheme(context).h4sb.copyWith(
                color: getColorScheme(context).colorText,
                height: 1.28,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          getAppLocalizations(context).input_profile_disease_subtitle,
          style: getTextTheme(context).c1r.copyWith(
                color: getColorScheme(context).neutral50,
              ),
        ),
      ],
    );
  }
}

class _SkipButton extends HookConsumerWidget {
  const _SkipButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final diseaseActiveStateList = ref.watch<List<DiseaseType>>(diseaseListStateProvider);
    final diseasesUiStateProvider = ref.read(inputDiseaseUiStateProvider.notifier);

    void patchDisease() => diseasesUiStateProvider.patchDisease(diseaseActiveStateList);

    return Expanded(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              getAppLocalizations(context).input_profile_disease_last_message,
              style: getTextTheme(context).c1r.copyWith(
                    color: getColorScheme(context).neutral60,
                  ),
            ),
            const SizedBox(height: 24),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: FillButton(
                text: getAppLocalizations(context).common_skip,
                type: ButtonSizeType.Normal,
                onPressed: () {
                  if (diseaseActiveStateList.isNotEmpty) {
                    patchDisease();
                  }
                },
                buttonProvider: StateNotifierProvider<ButtonNotifier, ButtonState>(
                  (_) => ButtonNotifier(
                    state: diseaseActiveStateList.isNotEmpty
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
