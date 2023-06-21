import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:ody_flutter_app/presentation/components/bottom_sheet/CommonBottomSheet.dart';
import 'package:ody_flutter_app/presentation/components/button/fill/FillButton.dart';
import 'package:ody_flutter_app/presentation/components/button/model/ButtonNotifier.dart';
import 'package:ody_flutter_app/presentation/components/button/model/ButtonSizeType.dart';
import 'package:ody_flutter_app/presentation/components/button/model/ButtonState.dart';
import 'package:ody_flutter_app/presentation/ui/colors.dart';
import 'package:ody_flutter_app/presentation/ui/typography.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';
import 'package:ody_flutter_app/presentation/utils/snackbar/SnackBarUtil.dart';

class BottomSheetTimeSetting extends HookWidget {
  final Function(int hour, int minute) callback;

  const BottomSheetTimeSetting({
    Key? key,
    required this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    int hour24 = now.hour;
    int hour12 = hour24 > 12 ? hour24 - 12 : hour24;
    int minute = now.minute;
    final isAm = useState(hour24 < 12 ? 0 : 1);
    final currentHourValue = useState(hour12);
    final currentMinValue = useState(minute);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 7),
          width: 35,
          height: 3,
          decoration: BoxDecoration(
            color: getColorScheme(context).neutral40,
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        const SizedBox(
          height: 32,
        ),
        Text(
          getAppLocalizations(context).bottom_sheet_time_setting_title,
          style: getTextTheme(context).t2b.copyWith(
                color: getColorScheme(context).colorText,
              ),
        ),
        const SizedBox(
          height: 40,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: NumberPicker(
                    textMapper: (value) {
                      return value == "0" ? '오전' : '오후';
                    },
                    value: isAm.value,
                    minValue: 0,
                    maxValue: 1,
                    onChanged: (value) => isAm.value = value,
                    selectedTextStyle: getTextTheme(context).l1b.copyWith(
                          color: getColorScheme(context).colorText,
                        ),
                    textStyle: getTextTheme(context).c1b.copyWith(
                          color: getColorScheme(context).colorPrimaryDisable,
                        ),
                    itemWidth: getMediaQuery(context).size.width * 0.2,
                    itemHeight: getMediaQuery(context).size.height * 0.05,
                  ),
                ),
                _divider(context),
              ],
            ),
            Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: NumberPicker(
                    value: currentHourValue.value,
                    minValue: 1,
                    maxValue: 12,
                    itemCount: 5,
                    onChanged: (value) => currentHourValue.value = value,
                    selectedTextStyle: getTextTheme(context).l1b.copyWith(
                          color: getColorScheme(context).colorText,
                        ),
                    textStyle: getTextTheme(context).c1b.copyWith(
                          color: getColorScheme(context).colorPrimaryDisable,
                        ),
                    itemWidth: getMediaQuery(context).size.width * 0.2,
                    itemHeight: getMediaQuery(context).size.height * 0.05,
                  ),
                ),
                _divider(context),
              ],
            ),
            Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: NumberPicker(
                    value: currentMinValue.value,
                    minValue: 0,
                    maxValue: 59,
                    itemCount: 5,
                    onChanged: (value) => currentMinValue.value = value,
                    selectedTextStyle: getTextTheme(context).l1b.copyWith(
                          color: getColorScheme(context).colorText,
                        ),
                    textStyle: getTextTheme(context).c1b.copyWith(
                          color: getColorScheme(context).colorPrimaryDisable,
                        ),
                    itemWidth: getMediaQuery(context).size.width * 0.2,
                    itemHeight: getMediaQuery(context).size.height * 0.05,
                  ),
                ),
                _divider(context),
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 40,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(35, 0, 35, 24),
          child: FillButton(
            text: getAppLocalizations(context).bottom_sheet_time_setting_complete,
            type: ButtonSizeType.Small,
            onPressed: () {
              callback.call(
                currentHourValue.value + (isAm.value == 0 ? 0 : 12),
                currentMinValue.value,
              );
              CommonBottomSheet.close(context);
            },
            buttonProvider: StateNotifierProvider<ButtonNotifier, ButtonState>(
              (_) => ButtonNotifier(
                state: ButtonState.Activated,
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _divider(BuildContext context) {
    return IgnorePointer(
      child: SizedBox(
        width: getMediaQuery(context).size.width * 0.2,
        height: getMediaQuery(context).size.height * 0.25,
        child: Align(
          alignment: Alignment.center,
          child: Container(
            width: getMediaQuery(context).size.width * 0.2,
            height: getMediaQuery(context).size.height * 0.05,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.symmetric(
                horizontal: BorderSide(
                  color: getColorScheme(context).neutral50,
                  width: 1,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
