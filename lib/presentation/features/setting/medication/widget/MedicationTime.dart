import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:odac_flutter_app/presentation/components/bottom_sheet/BottomSheetTimeSetting.dart';
import 'package:odac_flutter_app/presentation/components/bottom_sheet/CommonBottomSheet.dart';
import 'package:odac_flutter_app/presentation/features/setting/medication/provider/RegisterMedicineProvider.dart';
import 'package:odac_flutter_app/presentation/ui/colors.dart';
import 'package:odac_flutter_app/presentation/ui/typography.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';
import 'package:odac_flutter_app/presentation/utils/dto/Pair.dart';

class MedicationTime extends HookConsumerWidget {
  const MedicationTime({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// return Pair ( 오전 10시 11분, 10:11 )
    Pair<String, String> getTimeText(int hour, int minute) {
      int hour24 = hour;
      int hour12 = hour24 > 12 ? hour24 - 12 : hour24;
      final amText = hour24 < 12
          ? getAppLocalizations(context).common_am
          : getAppLocalizations(context).common_pm;

      return Pair(
          "$amText $hour12${getAppLocalizations(context).common_hour_unit} "
              "$minute${getAppLocalizations(context).common_minute_unit}",
          "${hour24.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}");
    }

    final uiStateRead = ref.read(registerMedicineProvider.notifier);
    final now = DateTime.now();
    final timeData = getTimeText(now.hour, now.minute);
    final ValueNotifier<String?> medicationTime = useState(timeData.first);

    useEffect(() {
      uiStateRead.updateMedicineTime(timeData.second);
    },[]);

    return Container(
      padding: const EdgeInsets.fromLTRB(35, 24, 35, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            getAppLocalizations(context).add_medication_time,
            style: getTextTheme(context).t4m.copyWith(
                  color: getColorScheme(context).colorText,
                ),
          ),
          const SizedBox(
            height: 16,
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: () {
                CommonBottomSheet.showBottomSheet(context, child: BottomSheetTimeSetting(
                  callback: (hour, minute) {
                    final timeData = getTimeText(hour, minute);
                    medicationTime.value = timeData.first;
                    uiStateRead.updateMedicineTime(timeData.second);
                  },
                ));
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: getColorScheme(context).neutral50,
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/imgs/icon_time.svg',
                      width: 24,
                      height: 24,
                      colorFilter: ColorFilter.mode(
                        getColorScheme(context).neutral50,
                        BlendMode.srcIn,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      medicationTime.value ?? getAppLocalizations(context).add_medication_time_text,
                      style: getTextTheme(context).l2m.copyWith(
                            color: getColorScheme(context).neutral50,
                          ),
                    )
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
