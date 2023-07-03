import 'package:flutter/material.dart';
import 'package:ody_flutter_app/presentation/features/analysis/widget/AnalysisItemTitle.dart';
import 'package:ody_flutter_app/presentation/features/main/home/widget/PainterCircleProgress.dart';
import 'package:ody_flutter_app/presentation/ui/colors.dart';
import 'package:ody_flutter_app/presentation/ui/typography.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';
import 'package:ody_flutter_app/presentation/utils/dto/Triple.dart';

class ReportCalorie extends StatelessWidget {
  const ReportCalorie({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: Column(
        children: [
          AnalysisItemTitle(
            title: getAppLocalizations(context).report_weekly_calorie_subtitle,
            secondTitle: Triple(
              getAppLocalizations(context).report_weekly_calorie_text1,
              "6,108kcal",
              getAppLocalizations(context).report_weekly_calorie_text2,
            ),
            description: getAppLocalizations(context).report_calorie_description,
          ),
          const SizedBox(height: 28,),
          SizedBox(
            width: 145,
            height: 145,
            child: Stack(
              children: [
                CustomCircle(
                  percentage: 0.5,
                  activeColor: getColorScheme(context).colorPrimaryFocus,
                  defaultColor: getColorScheme(context).colorPrimaryDisable,
                  strokeWidth: 13,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "6,108kcal",
                        style: getTextTheme(context).c1b.copyWith(
                          color: getColorScheme(context).colorText,
                        ),
                      ),
                      const SizedBox(height: 2,),
                      Text(
                        getAppLocalizations(context).report_weekly_base_calorie_recommend,
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


