import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ody_flutter_app/presentation/features/analysis/glucose/widget/AverageGlucose.dart';
import 'package:ody_flutter_app/presentation/ui/colors.dart';
import 'package:ody_flutter_app/presentation/ui/typography.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';
import 'package:ody_flutter_app/presentation/utils/dto/Triple.dart';
import 'package:ody_flutter_app/presentation/utils/regex/RegexUtil.dart';

class ReportGlucose extends HookWidget {
  final int totalCount;
  final int averageFasting;
  final int averagePreprandial;
  final int averagePostprandial;
  final int averagePostExercise;

  const ReportGlucose({
    Key? key,
    required this.totalCount,
    required this.averageFasting,
    required this.averagePreprandial,
    required this.averagePostprandial,
    required this.averagePostExercise,
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
              getAppLocalizations(context).analysis_glucose_record_range_text_unit(RegexUtil.commaNumber(totalCount)),
              getAppLocalizations(context).report_glucose_weekly_average_text2,
            ),
            description: getAppLocalizations(context).report_glucose_weekly_average_description,
            averageFasting: averageFasting,
            averagePreprandial: averagePreprandial,
            averagePostprandial: averagePostprandial,
            averagePostExercise: averagePostExercise,
          )
        ],
      ),
    );
  }
}
