import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ody_flutter_app/presentation/features/analysis/blood_pressure/widget/AverageBloodPressure.dart';
import 'package:ody_flutter_app/presentation/features/analysis/glucose/widget/AverageGlucose.dart';
import 'package:ody_flutter_app/presentation/ui/colors.dart';
import 'package:ody_flutter_app/presentation/ui/typography.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';
import 'package:ody_flutter_app/presentation/utils/dto/Triple.dart';

class ReportGlucose extends HookWidget {
  const ReportGlucose({Key? key}) : super(key: key);

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
                'assets/imgs/icon_blood_sugar.png',
                width: 24,
                height: 24,
              ),
              const SizedBox(width: 8),
              Text(
                getAppLocalizations(context).report_glucose_title,
                style: getTextTheme(context).t1b.copyWith(
                      color: getColorScheme(context).colorText,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          AverageGlucose(
            title: getAppLocalizations(context).report_glucose_weekly_average_subtitle,
            secondTitle: Triple(
              getAppLocalizations(context).report_glucose_weekly_average_text1,
              getAppLocalizations(context).analysis_glucose_record_range_text_unit(4),
              getAppLocalizations(context).report_glucose_weekly_average_text2,
            ),
            description: getAppLocalizations(context).report_glucose_weekly_average_description,
            averageFasting: 86,
            averagePreprandial: 96,
            averagePostprandial: 119,
            averagePostExercise: 120,
          )
        ],
      ),
    );
  }
}
