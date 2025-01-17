import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ody_flutter_app/presentation/features/analysis/blood_pressure/widget/AverageBloodPressure.dart';
import 'package:ody_flutter_app/presentation/ui/colors.dart';
import 'package:ody_flutter_app/presentation/ui/typography.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';
import 'package:ody_flutter_app/presentation/utils/dto/Triple.dart';
import 'package:ody_flutter_app/presentation/utils/regex/RegexUtil.dart';

class ReportBloodPressure extends HookWidget {
  final bool isWeekly;
  final int totalCount;
  final int averageSystolic;
  final int averageDiastolic;
  final int averageHeartRate;

  const ReportBloodPressure({
    Key? key,
    required this.isWeekly,
    required this.totalCount,
    required this.averageSystolic,
    required this.averageDiastolic,
    required this.averageHeartRate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 43, 16, 0),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/imgs/icon_blood_pressure.png',
                width: 24,
                height: 24,
              ),
              const SizedBox(width: 8),
              Text(
                getAppLocalizations(context).report_blood_pressure_title,
                style: getTextTheme(context).t1b.copyWith(
                      color: getColorScheme(context).colorText,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          AverageBloodPressure(
            title: isWeekly
                ? getAppLocalizations(context).report_blood_pressure_weekly_average_subtitle
                : getAppLocalizations(context).report_blood_pressure_monthly_average_subtitle,
            secondTitle: Triple(
              isWeekly
                  ? getAppLocalizations(context).report_blood_pressure_weekly_average_text1
                  : getAppLocalizations(context).report_blood_pressure_monthly_average_text1,
              getAppLocalizations(context).analysis_blood_pressure_average_measure_text_unit(
                RegexUtil.commaNumber(totalCount),
              ),
              isWeekly
                  ? getAppLocalizations(context).report_blood_pressure_weekly_average_text2
                  : getAppLocalizations(context).report_blood_pressure_monthly_average_text2,
            ),
            description: getAppLocalizations(context).report_blood_pressure_weekly_description,
            averageHeartRate: averageHeartRate,
            averageSystolic: averageSystolic,
            averageDiastolic: averageDiastolic,
          ),
        ],
      ),
    );
  }
}
