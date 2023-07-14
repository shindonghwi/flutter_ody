import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ody_flutter_app/presentation/components/bottom_sheet/BottomSheetBPTable.dart';
import 'package:ody_flutter_app/presentation/components/bottom_sheet/CommonBottomSheet.dart';
import 'package:ody_flutter_app/presentation/features/record/blood_pressure/notifier/BloodPressureRecorderNotifier.dart';
import 'package:ody_flutter_app/presentation/ui/colors.dart';
import 'package:ody_flutter_app/presentation/ui/typography.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';

import '../../widget/RecordInputTextField.dart';

class RecordBloodPressureInput extends HookWidget {
  const RecordBloodPressureInput({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          _bloodPressureTitle(context),
          const SizedBox(height: 24),
          const _InputBloodPressureTextField(),
          const SizedBox(height: 16),
          const _InputBloodHeartBeatTextField(),
        ],
      ),
    );
  }

  /// 혈압 기록 제목
  Row _bloodPressureTitle(BuildContext context) {
    return Row(
      children: [
        Text(
          getAppLocalizations(context).record_blood_pressure_input_title,
          style: getTextTheme(context).t2b.copyWith(
                color: getColorScheme(context).colorText,
                height: 1.2,
              ),
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(width: 8),
        Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(100),
            onTap: () {
              CommonBottomSheet.showBottomSheet(context, child: const BottomSheetBPTable());
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

class _InputBloodPressureTextField extends HookConsumerWidget {
  const _InputBloodPressureTextField({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bgRecorderRead = ref.read(bloodPressureRecorderProvider.notifier);

    return Container(
      width: double.infinity,
      height: 48,
      decoration: BoxDecoration(
        border: Border.all(
          color: getColorScheme(context).neutral50,
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            flex: 6,
            fit: FlexFit.tight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: 38,
                  child: RecordInputTextField(
                    hint: getAppLocalizations(context).record_blood_pressure_input1_hint1,
                    textInputType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    onNextAction: () => FocusScope.of(context).nextFocus(),
                    onChanged: (value) {
                      bgRecorderRead.updateSystolicBloodPressure(int.parse(value));
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
                SizedBox(
                  width: 38,
                  child: RecordInputTextField(
                    textInputType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    hint: getAppLocalizations(context).record_blood_pressure_input1_hint2,
                    onNextAction: () => FocusScope.of(context).nextFocus(),
                    onChanged: (value) {
                      bgRecorderRead.updateDiastolicBloodPressure(int.parse(value));
                      if (value.length == 3) {
                        FocusScope.of(context).nextFocus();
                      }
                    },
                  ),
                ),
                const SizedBox(width: 9),
              ],
            ),
          ),
          Flexible(
            flex: 4,
            fit: FlexFit.tight,
            child: Padding(
              padding: const EdgeInsets.only(left: 4.0),
              child: Text(
                getAppLocalizations(context).record_blood_pressure_input1_unit,
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

class _InputBloodHeartBeatTextField extends HookConsumerWidget {
  const _InputBloodHeartBeatTextField({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bgRecorderRead = ref.read(bloodPressureRecorderProvider.notifier);

    return Container(
      width: double.infinity,
      height: 48,
      decoration: BoxDecoration(
        border: Border.all(
          color: getColorScheme(context).neutral50,
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            flex: 6,
            fit: FlexFit.tight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: 70,
                  height: double.infinity,
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
                      int? parsedValue;
                      if (value.isNotEmpty) {
                        parsedValue = int.tryParse(value);
                      }
                      bgRecorderRead.updateHeartRate(parsedValue ?? 0);
                      if (value.length == 3) {
                        FocusScope.of(context).unfocus();
                      }
                    },
                  ),
                ),
                const SizedBox(width: 16),
              ],
            ),
          ),
          Flexible(
            flex: 4,
            fit: FlexFit.tight,
            child: SizedBox(
              height: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(left: 4.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    getAppLocalizations(context).record_blood_pressure_input2_unit,
                    style: getTextTheme(context).l3m.copyWith(
                          color: getColorScheme(context).neutral70,
                        ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
