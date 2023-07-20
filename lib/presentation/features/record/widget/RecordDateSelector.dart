import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:ody_flutter_app/presentation/components/bottom_sheet/BottomSheetTimeSetting.dart';
import 'package:ody_flutter_app/presentation/components/bottom_sheet/CommonBottomSheet.dart';
import 'package:ody_flutter_app/presentation/features/record/blood_pressure/notifier/BloodPressureRecorderNotifier.dart';
import 'package:ody_flutter_app/presentation/features/record/glucose/notifier/GlucoseRecorderNotifier.dart';
import 'package:ody_flutter_app/presentation/features/record/model/RecordType.dart';
import 'package:ody_flutter_app/presentation/ui/colors.dart';
import 'package:ody_flutter_app/presentation/ui/typography.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';
import 'package:ody_flutter_app/presentation/utils/date/DateTransfer.dart';
import 'package:ody_flutter_app/presentation/utils/picker/TimePicker.dart';

class RecordDateSelector extends HookConsumerWidget {
  final RecordType type;

  const RecordDateSelector({super.key, required this.type});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bpRead = ref.read(bloodPressureRecorderProvider.notifier);
    final glucoseRead = ref.read(glucoseRecorderProvider.notifier);

    final selectedTime = useState<String>(
      DateTransfer.dateTimeToAmPmTime(DateTime.now()),
    );

    // 시간을 선택하는 픽커
    showTimeSelectPicker() async {
      CommonBottomSheet.showBottomSheet(context, child: BottomSheetTimeSetting(
        callback: (hour, minute) {
          final selectDateTime = DateTime.now().copyWith(
            hour: hour,
            minute: minute,
          );
          if (type == RecordType.BloodPressure) {
            bpRead.updateTime(selectDateTime);
          } else {
            glucoseRead.updateTime(selectDateTime);
          }
          selectedTime.value = DateTransfer.dateTimeToAmPmTime(
            DateTime.now().copyWith(hour: hour, minute: minute),
          );
        },
      ));
    }

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: getColorScheme(context).white,
        borderRadius: BorderRadius.circular(5),
      ),
      margin: const EdgeInsets.only(top: 16, left: 15, right: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 24.0, top: 12, bottom: 12),
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
                padding: const EdgeInsets.only(right: 24.0, top: 12, bottom: 12),
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
