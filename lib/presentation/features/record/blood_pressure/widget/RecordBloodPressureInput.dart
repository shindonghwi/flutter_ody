import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:odac_flutter_app/presentation/ui/colors.dart';
import 'package:odac_flutter_app/presentation/ui/typography.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';

import '../../widget/RecordInputTextField.dart';

class RecordBloodPressureInput extends HookWidget {
  const RecordBloodPressureInput({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          _BloodPressureTitle(context),
          SizedBox(height: 22),
          _InputBloodPressureTextField(),
          SizedBox(height: 18),
          _InputBloodHeartBeatTextField(),
        ],
      ),
    );
  }

  /** 혈압 기록 제목 */
  Row _BloodPressureTitle(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          getAppLocalizations(context).record_blood_pressure,
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

class _InputBloodPressureTextField extends StatelessWidget {
  const _InputBloodPressureTextField({
    super.key,
  });

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
                  width: 38,
                  child: RecordInputTextField(
                    hint: getAppLocalizations(context).record_blood_pressure_input1_hint1,
                    textInputType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    onNextAction: () => FocusScope.of(context).nextFocus(),
                    onChanged: (value) {
                      if (value.length == 3) {
                        FocusScope.of(context).nextFocus();
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    "-",
                    style: getTextTheme(context).t2b.copyWith(
                          color: getColorScheme(context).neutral70,
                        ),
                  ),
                ),
                Container(
                  width: 38,
                  child: RecordInputTextField(
                    textInputType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    hint: getAppLocalizations(context).record_blood_pressure_input1_hint2,
                    onNextAction: () => FocusScope.of(context).nextFocus(),
                    onChanged: (value) {
                      if (value.length == 3) {
                        FocusScope.of(context).nextFocus();
                      }
                    },
                  ),
                ),
                SizedBox(width: 9),
              ],
            ),
            flex: 6,
            fit: FlexFit.tight,
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(left: 4.0),
              child: Text(
                getAppLocalizations(context).record_blood_pressure_input1_unit,
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

class _InputBloodHeartBeatTextField extends StatelessWidget {
  const _InputBloodHeartBeatTextField({
    super.key,
  });

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
                    hint: getAppLocalizations(context).record_blood_pressure_input2_hint,
                    textStyle: getTextTheme(context).t3sb.copyWith(
                          color: getColorScheme(context).colorText,
                        ),
                    hintTextStyle: getTextTheme(context).t3sb.copyWith(
                          color: getColorScheme(context).neutral60,
                        ),
                    onDoneAction: () => FocusScope.of(context).unfocus(),
                    onChanged: (value) {
                      if (value.length == 2) {
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
                getAppLocalizations(context).record_blood_pressure_input2_unit,
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
