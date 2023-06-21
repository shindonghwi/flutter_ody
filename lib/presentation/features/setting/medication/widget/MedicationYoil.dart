import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:odac_flutter_app/domain/models/me/YoilType.dart';
import 'package:odac_flutter_app/presentation/features/setting/medication/provider/RegisterMedicineProvider.dart';
import 'package:odac_flutter_app/presentation/ui/colors.dart';
import 'package:odac_flutter_app/presentation/ui/typography.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';
import 'package:odac_flutter_app/presentation/utils/dto/Pair.dart';

class MedicationYoil extends HookConsumerWidget {
  const MedicationYoil({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Pair<YoilType, String>> yoilList = [
      Pair(YoilType.MONDAY, getAppLocalizations(context).common_monday),
      Pair(YoilType.TUESDAY, getAppLocalizations(context).common_tuesday),
      Pair(YoilType.WEDNESDAY, getAppLocalizations(context).common_wednesday),
      Pair(YoilType.THURSDAY, getAppLocalizations(context).common_thursday),
      Pair(YoilType.FRIDAY, getAppLocalizations(context).common_friday),
      Pair(YoilType.SATURDAY, getAppLocalizations(context).common_saturday),
      Pair(YoilType.SUNDAY, getAppLocalizations(context).common_sunday),
    ];

    final selectedYoilList = useState<List<YoilType>>([]);
    final uiStateRead = ref.read(registerMedicineProvider.notifier);

    return Container(
      padding: const EdgeInsets.fromLTRB(35, 24, 35, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            getAppLocalizations(context).add_medication_yoil,
            style: getTextTheme(context).t4m.copyWith(
                  color: getColorScheme(context).colorText,
                ),
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: yoilList
                .map((e) => Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: selectedYoilList.value.contains(e.first)
                              ? getColorScheme(context).colorPrimaryFocus
                              : getColorScheme(context).neutral50,
                          width: 1,
                        ),
                        color: selectedYoilList.value.contains(e.first)
                            ? getColorScheme(context).colorPrimaryFocus
                            : getColorScheme(context).colorUI01,
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(100),
                          onTap: () {
                            if (selectedYoilList.value.contains(e.first)) {
                              selectedYoilList.value = [...selectedYoilList.value..remove(e.first)];
                            } else {
                              selectedYoilList.value = [...selectedYoilList.value..add(e.first)];
                            }
                            uiStateRead.updateMedicineYoil(selectedYoilList.value);
                          },
                          child: Center(
                            child: Text(
                              e.second,
                              style: getTextTheme(context).l2m.copyWith(
                                    color: selectedYoilList.value.contains(e.first)
                                        ? getColorScheme(context).white
                                        : getColorScheme(context).colorText,
                                  ),
                            ),
                          ),
                        ),
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}
