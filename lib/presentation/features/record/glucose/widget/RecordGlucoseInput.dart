import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:odac_flutter_app/domain/models/bio/GlucoseMesaureType.dart';
import 'package:odac_flutter_app/presentation/components/bottom_sheet/BottomSheetGlucoseTable.dart';
import 'package:odac_flutter_app/presentation/components/bottom_sheet/CommonBottomSheet.dart';
import 'package:odac_flutter_app/presentation/components/button/model/ButtonNotifier.dart';
import 'package:odac_flutter_app/presentation/components/button/model/ButtonSizeType.dart';
import 'package:odac_flutter_app/presentation/components/button/model/ButtonState.dart';
import 'package:odac_flutter_app/presentation/components/button/outline/OutlineRoundNeutralButton.dart';
import 'package:odac_flutter_app/presentation/features/record/glucose/notifier/GlucoseRecorderNotifier.dart';
import 'package:odac_flutter_app/presentation/ui/colors.dart';
import 'package:odac_flutter_app/presentation/ui/typography.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';

import '../../widget/RecordInputTextField.dart';

class RecordGlucoseInput extends HookWidget {
  const RecordGlucoseInput({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _glucoseTitle(context),
        const SizedBox(height: 16),
        const _SelectorMealType(),
        const SizedBox(height: 16),
        const _InputGlucoseTextField(),
      ],
    );
  }

  /// 혈당 기록 제목
  Row _glucoseTitle(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          getAppLocalizations(context).record_glucose_input_title,
          style: getTextTheme(context).t2b.copyWith(
                color: getColorScheme(context).colorText,
              ),
        ),
        const SizedBox(width: 8),
        Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(100),
            onTap: (){
              CommonBottomSheet.showBottomSheet(context, child: const BottomSheetGlucoseTable());
            },
            child: SvgPicture.asset(
              'assets/imgs/icon_information.svg',
              colorFilter: ColorFilter.mode(
                getColorScheme(context).neutral60,
                BlendMode.srcIn,
              ),
              width: 24,
              height: 24,
            ),
          ),
        ),
      ],
    );
  }
}

/// 식사 상태 선택
class _SelectorMealType extends HookConsumerWidget {
  const _SelectorMealType({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final glucoseRecorderRead = ref.read(glucoseRecorderProvider.notifier);

    final measureTypeList = [
      GlucoseMeasureType.Fasting,
      GlucoseMeasureType.BeforeMeal,
      GlucoseMeasureType.AfterMeals,
      GlucoseMeasureType.PostWorkout,
    ];

    final selectedMeasureType = useState<GlucoseMeasureType?>(null);

    return SizedBox(
      width: double.infinity,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: measureTypeList.map((e) {
            return SizedBox(
              width: 68,
              child: OutlineRoundNeutralButton(
                text: GlucoseMeasureTypeHelper.fromString(e),
                onPressed: () {
                  if (selectedMeasureType.value == e) {
                    selectedMeasureType.value = null;
                    glucoseRecorderRead.updateMeasureType(GlucoseMeasureType.None);
                  }else{
                    glucoseRecorderRead.updateMeasureType(e);
                    selectedMeasureType.value = e;
                  }
                },
                type: ButtonSizeType.XSmall,
                buttonProvider: StateNotifierProvider<ButtonNotifier, ButtonState>(
                  (_) => ButtonNotifier(
                    state: selectedMeasureType.value == e ? ButtonState.Activated : ButtonState.Default,
                  ),
                ),
              ),
            );
          }).toList()),
    );
  }
}

class _InputGlucoseTextField extends HookConsumerWidget {
  const _InputGlucoseTextField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final glucoseRecorderRead = ref.read(glucoseRecorderProvider.notifier);

    return Container(
      width: double.infinity,
      height: 48,
      decoration: BoxDecoration(
        border: Border.all(color: getColorScheme(context).neutral50, width: 1.5),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            flex: 6,
            fit: FlexFit.tight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: 70,
                  child: RecordInputTextField(
                    textInputType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    hint: getAppLocalizations(context).record_glucose_input_hint,
                    textStyle: getTextTheme(context).t3sb.copyWith(
                          color: getColorScheme(context).colorText,
                        ),
                    hintTextStyle: getTextTheme(context).t3sb.copyWith(
                          color: getColorScheme(context).neutral60,
                        ),
                    onDoneAction: () => FocusScope.of(context).unfocus(),
                    onChanged: (value) {
                      int? parsedValue;
                      if (value.isNotEmpty) {
                        parsedValue = int.tryParse(value);
                      }
                      glucoseRecorderRead.updateGlucose(parsedValue ?? 0);

                      if (value.length == 3) {
                        FocusScope.of(context).unfocus();
                      }
                    },
                  ),
                ),
                const SizedBox(width: 22),
              ],
            ),
          ),
          Flexible(
            flex: 4,
            fit: FlexFit.tight,
            child: Padding(
              padding: const EdgeInsets.only(left: 4.0),
              child: Text(
                getAppLocalizations(context).record_glucose_input_unit,
                style: getTextTheme(context).l3m.copyWith(
                      color: getColorScheme(context).neutral70,
                    ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
