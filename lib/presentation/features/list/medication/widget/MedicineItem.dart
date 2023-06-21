import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:odac_flutter_app/data/models/me/ResponseMeMedicineModel.dart';
import 'package:odac_flutter_app/domain/models/me/YoilType.dart';
import 'package:odac_flutter_app/presentation/components/checkbox/switch/SwitchCheckBox.dart';
import 'package:odac_flutter_app/presentation/ui/colors.dart';
import 'package:odac_flutter_app/presentation/ui/typography.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';

class MedicineItem extends HookWidget {
  final ResponseMeMedicineModel data;

  const MedicineItem({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final switchState = useState(data.enabled);

    final medicineName = data.name;

    final hour24 = int.parse(data.time.split(":").first);
    int hour12 = hour24 > 12 ? hour24 - 12 : hour24;
    final minute = int.parse(data.time.split(":").last);
    final amText = hour24 < 12
        ? getAppLocalizations(context).common_am
        : getAppLocalizations(context).common_pm;

    final String? yoilList = data.days?.map(
      (e) {
        return YoilTypeHelper.yoilTypeCodeToText(
          YoilTypeHelper.stringToYoilType(e),
        );
      },
    ).join(" ");

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: switchState.value
              ? getColorScheme(context).primary100
              : getColorScheme(context).colorPrimaryDisable,
          width: 1.5,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              medicineName.toString(),
              style: getTextTheme(context).t2b.copyWith(
                    color: switchState.value
                        ? getColorScheme(context).colorText
                        : getColorScheme(context).neutral70,
                  ),
              maxLines: 1,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "$amText ${hour12.toString().padLeft(2, '0')}${getAppLocalizations(context).common_hour_unit} ${minute.toString().padLeft(2, '0')}${getAppLocalizations(context).common_minute_unit}",
                      style: getTextTheme(context).b3sb.copyWith(
                            color: switchState.value
                                ? getColorScheme(context).colorText
                                : getColorScheme(context).neutral70,
                          ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      yoilList.toString(),
                      style: getTextTheme(context).c2r.copyWith(
                            color: switchState.value
                                ? getColorScheme(context).colorText
                                : getColorScheme(context).neutral70,
                          ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 16,
                ),
                SizedBox(
                  width: 43,
                  height: 26,
                  child: SwitchCheckBox(
                    isOn: switchState.value,
                    onChanged: (value) {
                      switchState.value = value;
                    },
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
