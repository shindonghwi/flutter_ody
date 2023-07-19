import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ody_flutter_app/data/models/me/RequestMeMedicineUpdateModel.dart';
import 'package:ody_flutter_app/data/models/me/ResponseMeMedicineModel.dart';
import 'package:ody_flutter_app/domain/models/me/YoilType.dart';
import 'package:ody_flutter_app/domain/usecases/remote/me/PatchMeMedicineUseCase.dart';
import 'package:ody_flutter_app/presentation/components/checkbox/checkbox/BasicBorderCheckBox.dart';
import 'package:ody_flutter_app/presentation/components/checkbox/model/CheckBoxSize.dart';
import 'package:ody_flutter_app/presentation/components/checkbox/model/CheckBoxType.dart';
import 'package:ody_flutter_app/presentation/components/checkbox/switch/SwitchCheckBox.dart';
import 'package:ody_flutter_app/presentation/features/list/medication/provider/MedicineCheckListProvider.dart';
import 'package:ody_flutter_app/presentation/features/list/medication/provider/MedicineListProvider.dart';
import 'package:ody_flutter_app/presentation/features/list/medication/provider/MedicineScreenModeProvider.dart';
import 'package:ody_flutter_app/presentation/features/setting/medication/provider/RegisterMedicineProvider.dart';
import 'package:ody_flutter_app/presentation/ui/colors.dart';
import 'package:ody_flutter_app/presentation/ui/typography.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';
import 'package:ody_flutter_app/presentation/utils/date/DateTransfer.dart';
import 'package:ody_flutter_app/presentation/utils/notifications/NotificationsUtil.dart';

class MedicineItem extends HookConsumerWidget {
  final ResponseMeMedicineModel data;

  const MedicineItem({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final checkList = ref.watch(medicineCheckListProvider);
    final checkListRead = ref.read(medicineCheckListProvider.notifier);
    final isEditMode = ref.watch(medicineScreenModeProvider);
    final uiStateRead = ref.read(medicineListProvider.notifier);
    final registerMedicationRead = ref.read(registerMedicineProvider.notifier);

    // 약 스위치
    final switchState = useState(data.enabled);

    // 약 이름
    final medicineName = data.name;

    // 약 알림 시간
    final hour24 = int.parse(data.time.split(":").first);
    int hour12 = hour24 > 12 ? hour24 - 12 : hour24;
    final minute = int.parse(data.time.split(":").last);
    final amText = hour24 < 12 ? getAppLocalizations(context).common_am : getAppLocalizations(context).common_pm;

    // 약 요일 정보
    List<String>? yoilList = data.days?.map(
      (e) {
        return YoilTypeHelper.yoilTypeCodeToText(
          YoilTypeHelper.stringToYoilType(e),
        );
      },
    ).toList();

    if (yoilList?.length != 7) {
      yoilList?.sort((a, b) {
        List<String> order = window.locales.contains("en")
            ? ['Mon', 'Tue', 'Wed', 'Thr', 'Fri', 'Sat', 'Sun']
            : ['월', '화', '수', '목', '금', '토', '일'];
        return order.indexOf(a) - order.indexOf(b);
      });
    } else {
      yoilList = [getAppLocalizations(context).common_every];
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: isEditMode ? () => checkListRead.click(data) : null,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: !isEditMode
                  ? switchState.value
                      ? getColorScheme(context).primary100
                      : getColorScheme(context).colorPrimaryDisable
                  : checkList.contains(data)
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
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    if (isEditMode)
                      Container(
                        width: 18,
                        height: 18,
                        margin: const EdgeInsets.only(right: 16),
                        child: BasicBorderCheckBox(
                          isChecked: checkList.contains(data),
                          size: CheckBoxSize.Small,
                          type: CheckBoxType.Circle,
                          onChange: (bool value) {
                            checkListRead.click(data);
                          },
                        ),
                      ),
                    Text(
                      medicineName.length >= 9 ? '${medicineName.substring(0, 8)}...' : medicineName,
                      style: getTextTheme(context).t2b.copyWith(
                            color: !isEditMode
                                ? switchState.value
                                    ? getColorScheme(context).colorText
                                    : getColorScheme(context).neutral70
                                : checkList.contains(data)
                                    ? getColorScheme(context).colorText
                                    : getColorScheme(context).neutral70,
                          ),
                      maxLines: 1,
                    ),
                  ],
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
                                color: !isEditMode
                                    ? switchState.value
                                        ? getColorScheme(context).colorText
                                        : getColorScheme(context).neutral70
                                    : checkList.contains(data)
                                        ? getColorScheme(context).colorText
                                        : getColorScheme(context).neutral70,
                              ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          yoilList?.join(" ") ?? "",
                          style: getTextTheme(context).c2r.copyWith(
                                color: !isEditMode
                                    ? switchState.value
                                        ? getColorScheme(context).colorText
                                        : getColorScheme(context).neutral70
                                    : checkList.contains(data)
                                        ? getColorScheme(context).colorText
                                        : getColorScheme(context).neutral70,
                              ),
                        ),
                      ],
                    ),
                    if (!isEditMode)
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(
                            width: 16,
                          ),
                          SizedBox(
                            width: 43,
                            height: 26,
                            child: SwitchCheckBox(
                              isOn: switchState.value,
                              onChanged: (value) async {
                                final isSuccess = await uiStateRead.updateMedicineState(data.medicineSeq ?? -1, value);
                                if (isSuccess) {
                                  switchState.value = value;
                                  if (value) {
                                    registerMedicationRead.registerMedicineNotificationFromInfo(
                                      scheduledDays: data.days?.map((e) => DateTransfer.convertShortEnYoilToYoilType(e)).toList(),
                                      notificationId: data.medicineSeq!,
                                      name: data.name!,
                                      hour: hour24,
                                      minutes: minute,
                                    );
                                  } else {
                                    NotificationsUtil.removeNotification(data.medicineSeq!);
                                  }
                                }
                              },
                            ),
                          )
                        ],
                      ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
