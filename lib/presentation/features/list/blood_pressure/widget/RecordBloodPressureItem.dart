import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ody_flutter_app/data/models/bio/ResponseBioBloodPressureModel.dart';
import 'package:ody_flutter_app/presentation/features/record/model/RecordRangeStatus.dart';
import 'package:ody_flutter_app/presentation/ui/colors.dart';
import 'package:ody_flutter_app/presentation/ui/typography.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';

class RecordBloodPressureItem extends HookWidget {
  final ResponseBioBloodPressureModel model;

  const RecordBloodPressureItem({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hour24 = int.parse(model.createdAt.split(":").first);
    final amText = hour24 < 12 ? getAppLocalizations(context).common_am : getAppLocalizations(context).common_pm;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$amText ${model.createdAt}",
          style: getTextTheme(context).b3sb.copyWith(
                color: getColorScheme(context).neutral70,
              ),
        ),
        const SizedBox(
          height: 8,
        ),
        Container(
          height: 76,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: getColorScheme(context).white,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "${model.systolicBloodPressure} - ${model.diastolicBloodPressure}",
                          style: getTextTheme(context).b2b.copyWith(
                                color: getColorScheme(context).colorText,
                              ),
                        ),
                        const WidgetSpan(
                          child: SizedBox(width: 6),
                        ),
                        TextSpan(
                          text: getAppLocalizations(context).home_today_record_blood_pressure_unit1,
                          style: getTextTheme(context).c2b.copyWith(
                                color: getColorScheme(context).neutral70,
                              ),
                        ),
                      ],
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: model.heartRate.toString(),
                          style: getTextTheme(context).b2b.copyWith(
                                color: getColorScheme(context).colorText,
                              ),
                        ),
                        const WidgetSpan(
                          child: SizedBox(width: 6),
                        ),
                        TextSpan(
                          text: getAppLocalizations(context).home_today_record_blood_pressure_unit2,
                          style: getTextTheme(context).c2b.copyWith(
                                color: getColorScheme(context).neutral70,
                              ),
                        ),
                      ],
                    ),
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
              Text(
                model.status.name.toString(),
                style: getTextTheme(context).b2b.copyWith(
                      color: RecordRangeStatusHelper.getStatusTextColor(
                        context,
                        RecordRangeStatusHelper.getBPRecordRangeStatusFromCode(model.status.code),
                      ),
                    ),
              )
            ],
          ),
        )
      ],
    );
  }
}
