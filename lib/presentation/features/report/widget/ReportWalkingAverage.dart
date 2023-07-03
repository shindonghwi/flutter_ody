import 'package:flutter/material.dart';
import 'package:ody_flutter_app/presentation/components/progress/PainterLInearVerticalProgress.dart';
import 'package:ody_flutter_app/presentation/features/analysis/widget/AnalysisItemTitle.dart';
import 'package:ody_flutter_app/presentation/ui/colors.dart';
import 'package:ody_flutter_app/presentation/ui/typography.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';
import 'package:ody_flutter_app/presentation/utils/date/DateChecker.dart';
import 'package:ody_flutter_app/presentation/utils/dto/Pair.dart';
import 'package:ody_flutter_app/presentation/utils/dto/Triple.dart';

class ReportWalkingAverage extends StatelessWidget {
  const ReportWalkingAverage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: Column(
        children: [
          AnalysisItemTitle(
            title: getAppLocalizations(context).report_weekly_average_subtitle,
            secondTitle: Triple(
              getAppLocalizations(context).report_walk_average_text1,
              "6,108kcal",
              getAppLocalizations(context).report_walk_average_text2,
            ),
            description: getAppLocalizations(context).report_calorie_description,
          ),
          const SizedBox(
            height: 32,
          ),
          const Align(
            alignment: Alignment.center,
            child: _YoilGraph(),
          )
        ],
      ),
    );
  }
}

class _YoilGraph extends StatelessWidget {
  const _YoilGraph({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final yoilData = [
      Pair(getAppLocalizations(context).common_monday, 7988),
      Pair(getAppLocalizations(context).common_tuesday, 5232),
      Pair(getAppLocalizations(context).common_wednesday, 2332),
      Pair(getAppLocalizations(context).common_thursday, 1111),
      Pair(getAppLocalizations(context).common_friday, 0),
      Pair(getAppLocalizations(context).common_saturday, 5677),
      Pair(getAppLocalizations(context).common_sunday, 11220),
    ];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 80),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: yoilData.map((e) {
          return Column(
            children: [
              SizedBox(
                width: 14,
                height: 110,
                child: CustomPaint(
                  painter: PainterLinearVerticalProgress(
                    progress: e.second.toDouble() / 10000.0,
                    defaultColor: getColorScheme(context).colorUI02,
                    activeColor: getColorScheme(context).primary100.withOpacity(
                          DateChecker.isTodayCheckFromYoil(e.first) ? 1 : 0.1,
                        ),
                    radius: 100,
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                e.first,
                style: getTextTheme(context).c3b.copyWith(
                      color: DateChecker.isTodayCheckFromYoil(e.first)
                          ? getColorScheme(context).colorPrimaryFocus
                          : getColorScheme(context).neutral70,
                    ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
