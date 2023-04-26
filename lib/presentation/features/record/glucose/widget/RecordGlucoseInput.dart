import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:odac_flutter_app/presentation/components/button/model/ButtonNotifier.dart';
import 'package:odac_flutter_app/presentation/components/button/model/ButtonSizeType.dart';
import 'package:odac_flutter_app/presentation/components/button/model/ButtonState.dart';
import 'package:odac_flutter_app/presentation/components/button/outline/OutlineRoundNeutralButton.dart';
import 'package:odac_flutter_app/presentation/ui/colors.dart';
import 'package:odac_flutter_app/presentation/ui/typography.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';
import 'package:odac_flutter_app/presentation/utils/dto/Pair.dart';

import '../../widget/RecordInputTextField.dart';

class RecordGlucoseInput extends HookWidget {
  const RecordGlucoseInput({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _GlucoseTitle(context),
        SizedBox(height: 22),
        _SelectorMealType(),
        SizedBox(height: 19),
        _InputGlucoseTextField(),
      ],
    );
  }

  /** 혈당 기록 제목 */
  Row _GlucoseTitle(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          getAppLocalizations(context).record_glucose_input_title,
          style: getTextTheme(context).t2b.copyWith(
                color: getColorScheme(context).colorText,
              ),
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(width: 10),
        SvgPicture.asset(
          'assets/imgs/icon_information.svg',
          colorFilter: ColorFilter.mode(
            getColorScheme(context).neutral60,
            BlendMode.srcIn,
          ),
          width: 24,
          height: 24,
        ),
      ],
    );
  }
}

/** 식사 상태 선택 */
class _SelectorMealType extends HookWidget {
  const _SelectorMealType({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Pair<String, ValueNotifier>> buttonList = [
      Pair(
        getAppLocalizations(context).record_glucose_input_state_empty,
        useState(
          StateNotifierProvider<ButtonNotifier, ButtonState>(
            (_) => ButtonNotifier(state: ButtonState.Default),
          ),
        ),
      ),
      Pair(
        getAppLocalizations(context).record_glucose_input_state_before_meal,
        useState(
          StateNotifierProvider<ButtonNotifier, ButtonState>(
            (_) => ButtonNotifier(state: ButtonState.Default),
          ),
        ),
      ),
      Pair(
        getAppLocalizations(context).record_glucose_input_state_after_meal,
        useState(
          StateNotifierProvider<ButtonNotifier, ButtonState>(
            (_) => ButtonNotifier(state: ButtonState.Default),
          ),
        ),
      ),
      Pair(
        getAppLocalizations(context).record_glucose_input_state_after_exercise,
        useState(
          StateNotifierProvider<ButtonNotifier, ButtonState>(
            (_) => ButtonNotifier(state: ButtonState.Default),
          ),
        ),
      ),
    ];

    return Container(
      width: double.infinity,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: buttonList.map((e) {
            return OutlineRoundNeutralButton(
              text: e.first,
              onPressed: () {},
              type: ButtonSizeType.Small,
              buttonProvider: e.second.value,
            );
          }).toList()),
    );
  }
}

class _InputGlucoseTextField extends StatelessWidget {
  const _InputGlucoseTextField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(color: getColorScheme(context).neutral50, width: 1.5),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
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
                      if (value.length == 3) {
                        FocusScope.of(context).unfocus();
                      }
                    },
                  ),
                ),
                SizedBox(width: 22),
              ],
            ),
            flex: 6,
            fit: FlexFit.tight,
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(left: 4.0),
              child: Text(
                getAppLocalizations(context).record_glucose_input_unit,
                style: getTextTheme(context).l3m.copyWith(
                      color: getColorScheme(context).neutral70,
                    ),
              ),
            ),
            flex: 4,
            fit: FlexFit.tight,
          )
        ],
      ),
    );
  }
}
