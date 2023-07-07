import 'package:flutter/material.dart';
import 'package:ody_flutter_app/presentation/features/analysis/widget/AnalysisItemTitle.dart';
import 'package:ody_flutter_app/presentation/features/main/home/widget/PainterCircleProgress.dart';
import 'package:ody_flutter_app/presentation/ui/colors.dart';
import 'package:ody_flutter_app/presentation/ui/typography.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';
import 'package:ody_flutter_app/presentation/utils/date/DateParser.dart';
import 'package:ody_flutter_app/presentation/utils/dto/Triple.dart';
import 'package:ody_flutter_app/presentation/utils/regex/RegexUtil.dart';

class ReportCalorie extends StatelessWidget {
  final bool isWeekly;
  final int totalCalories;

  const ReportCalorie({
    Key? key,
    required this.isWeekly,
    required this.totalCalories,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: Column(
        children: [
          AnalysisItemTitle(
            title: isWeekly
                ? getAppLocalizations(context).report_weekly_calorie_subtitle
                : getAppLocalizations(context).report_monthly_calorie_subtitle,
            secondTitle: Triple(
              isWeekly
                  ? getAppLocalizations(context).report_weekly_calorie_text1
                  : getAppLocalizations(context).report_monthly_calorie_text1,
              "${RegexUtil.commaNumber(totalCalories)}kcal",
              isWeekly
                  ? getAppLocalizations(context).report_weekly_calorie_text2
                  : getAppLocalizations(context).report_monthly_calorie_text2,
            ),
            description: getAppLocalizations(context).report_calorie_description,
          ),
          const SizedBox(
            height: 28,
          ),
          SizedBox(
            width: 145,
            height: 145,
            child: Stack(
              children: [
                CustomCircle(
                  percentage: 0.5,
                  activeColor: getColorScheme(context).colorPrimaryFocus,
                  defaultColor: getColorScheme(context).colorPrimaryDisable,
                  strokeWidth: 12,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${RegexUtil.commaNumber(totalCalories)}kcal",
                        style: getTextTheme(context).c1b.copyWith(
                              color: getColorScheme(context).colorText,
                            ),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Text(
                        "${RegexUtil.commaNumber((2000 * (isWeekly ? 7 : DateParser.getLastDayFromCurrentMonth())))}kcal",
                        style: getTextTheme(context).c3m.copyWith(
                              color: getColorScheme(context).neutral60,
                            ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
