import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:odac_flutter_app/presentation/features/record/blood_pressure/notifier/BloodPressureRecorderNotifier.dart';
import 'package:odac_flutter_app/presentation/ui/colors.dart';
import 'package:odac_flutter_app/presentation/ui/typography.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';
import 'package:odac_flutter_app/presentation/utils/date/DateTransfer.dart';
import 'package:odac_flutter_app/presentation/utils/picker/TimePicker.dart';

class RecordDateSelector extends HookConsumerWidget {
  const RecordDateSelector({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final bpRead = ref.read(bloodPressureRecorderProvider.notifier);

    final selectedTime = useState<String>(
      DateTransfer.dateTimeToAmPmTime(DateTime.now()),
    );

    // 시간을 선택하는 픽커
    showTimeSelectPicker() async {
      final result = await TimePicker.show(context);
      if (result != null) {
        final selectDateTime = DateTime.now().copyWith(
          hour: result.hour,
          minute: result.minute,
        );
        bpRead.updateTime(selectDateTime);
        selectedTime.value = DateTransfer.dateTimeToAmPmTime(
          DateTime.now().copyWith(hour: result.hour, minute: result.minute),
        );
      }
    }

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: getColorScheme(context).white,
        borderRadius: BorderRadius.circular(5),
      ),
      margin: const EdgeInsets.only(top: 10, left: 15, right: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/imgs/icon_calendar.svg',
                  colorFilter: ColorFilter.mode(
                    getColorScheme(context).neutral60,
                    BlendMode.srcIn,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  DateTransfer.dateTimeToYearMonthDay(DateTime.now()),
                  style: getTextTheme(context).l2m.copyWith(
                        color: getColorScheme(context).neutral80,
                      ),
                ),
              ],
            ),
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => showTimeSelectPicker(),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/imgs/icon_time.svg',
                      colorFilter: ColorFilter.mode(
                        getColorScheme(context).neutral60,
                        BlendMode.srcIn,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      selectedTime.value,
                      style: getTextTheme(context).l2m.copyWith(
                            color: getColorScheme(context).neutral80,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
