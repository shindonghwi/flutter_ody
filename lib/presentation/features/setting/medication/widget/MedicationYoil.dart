import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:odac_flutter_app/presentation/ui/colors.dart';
import 'package:odac_flutter_app/presentation/ui/typography.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';

class MedicationYoil extends HookWidget {
  const MedicationYoil({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final yoilList = [
      getAppLocalizations(context).common_monday,
      getAppLocalizations(context).common_tuesday,
      getAppLocalizations(context).common_wednesday,
      getAppLocalizations(context).common_thursday,
      getAppLocalizations(context).common_friday,
      getAppLocalizations(context).common_saturday,
      getAppLocalizations(context).common_sunday,
    ];

    final selectedYoilList = useState<List<String>>([]);

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
                          color: selectedYoilList.value.contains(e)
                              ? getColorScheme(context).colorPrimaryFocus
                              : getColorScheme(context).neutral50,
                          width: 1,
                        ),
                        color: selectedYoilList.value.contains(e)
                            ? getColorScheme(context).colorPrimaryFocus
                            : getColorScheme(context).colorUI01,
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(100),
                          onTap: () {
                            if (selectedYoilList.value.contains(e)) {
                              selectedYoilList.value = [...selectedYoilList.value..remove(e)];
                            } else {
                              selectedYoilList.value = [...selectedYoilList.value..add(e)];
                            }
                            debugPrint(selectedYoilList.value.toString());
                          },
                          child: Center(
                            child: Text(
                              e,
                              style: getTextTheme(context).l2m.copyWith(
                                    color: selectedYoilList.value.contains(e)
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
