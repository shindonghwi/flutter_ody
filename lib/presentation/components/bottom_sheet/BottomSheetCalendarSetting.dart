import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:ody_flutter_app/presentation/components/bottom_sheet/CommonBottomSheet.dart';
import 'package:ody_flutter_app/presentation/components/button/fill/FillButton.dart';
import 'package:ody_flutter_app/presentation/components/button/model/ButtonNotifier.dart';
import 'package:ody_flutter_app/presentation/components/button/model/ButtonSizeType.dart';
import 'package:ody_flutter_app/presentation/components/button/model/ButtonState.dart';
import 'package:ody_flutter_app/presentation/features/main/home/notifier/CalendarSelectDateNotifier.dart';
import 'package:ody_flutter_app/presentation/ui/colors.dart';
import 'package:ody_flutter_app/presentation/ui/typography.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';
import 'package:ody_flutter_app/presentation/utils/date/DateParser.dart';

class BottomSheetCalendarSetting extends HookConsumerWidget {
  final Function(DateTime datetime) callback;

  const BottomSheetCalendarSetting({
    Key? key,
    required this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final calendarSelectDateRead = ref.read(calendarSelectDateProvider.notifier);

    final now = DateTime.now();

    final currentTime = DateTime.now().copyWith(
      year: calendarSelectDateRead.getSelectedDatetime().year,
      month: calendarSelectDateRead.getSelectedDatetime().month,
      day: calendarSelectDateRead.getSelectedDatetime().day,
    );

    final yearState = useState(currentTime.year);
    final monthState = useState(currentTime.month);
    final dayState = useState(currentTime.day);

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
          getAppLocalizations(context).bottom_sheet_calendar_setting_title,
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
                      return "$value년";
                    },
                    value: yearState.value,
                    minValue: 2022,
                    maxValue: now.year,
                    itemCount: 5,
                    onChanged: (value) {
                      if (now.compareTo(DateTime(value, monthState.value, dayState.value)) <= 0) {
                        yearState.value = now.year;
                        return;
                      }
                      yearState.value = value;
                    },
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
                    value: monthState.value,
                    minValue: 1,
                    maxValue: 12,
                    itemCount: 5,
                    onChanged: (value) {
                      if (now.compareTo(DateTime(yearState.value, value, dayState.value)) <= 0) {
                        yearState.value = now.year;
                        monthState.value = now.month;
                        return;
                      }
                      monthState.value = value;
                    },
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
                    value: dayState.value,
                    minValue: 1,
                    maxValue: DateParser.getNumberOfDays(now.year, now.month),
                    itemCount: 5,
                    onChanged: (value) {
                      if (now.compareTo(DateTime(yearState.value, monthState.value, value)) <= 0) {
                        yearState.value = now.year;
                        monthState.value = now.month;
                        dayState.value = now.day;
                        return;
                      }
                      dayState.value = value;
                    },
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
            text: getAppLocalizations(context).bottom_sheet_setting_complete,
            type: ButtonSizeType.Small,
            onPressed: () {
              callback.call(DateTime(yearState.value, monthState.value, dayState.value));
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
