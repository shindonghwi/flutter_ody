import 'package:flutter/material.dart';
import 'package:ody_flutter_app/data/models/bio/ResponseBioReportDaysModel.dart';
import 'package:ody_flutter_app/presentation/components/progress/PainterLInearVerticalProgress.dart';
import 'package:ody_flutter_app/presentation/features/analysis/widget/AnalysisItemTitle.dart';
import 'package:ody_flutter_app/presentation/ui/colors.dart';
import 'package:ody_flutter_app/presentation/ui/typography.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';
import 'package:ody_flutter_app/presentation/utils/date/DateChecker.dart';
import 'package:ody_flutter_app/presentation/utils/dto/Pair.dart';
import 'package:ody_flutter_app/presentation/utils/dto/Triple.dart';
import 'package:ody_flutter_app/presentation/utils/regex/RegexUtil.dart';

class ReportWalkingAverage extends StatelessWidget {
  final int averageSteps;
  final List<ResponseBioReportDaysModel> days;

  const ReportWalkingAverage({
    Key? key,
    required this.averageSteps,
    required this.days,
  }) : super(key: key);

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
              "${RegexUtil.commaNumber(averageSteps)} ${getAppLocalizations(context).common_walk}",
              getAppLocalizations(context).report_walk_average_text2,
            ),
            description: getAppLocalizations(context).report_calorie_description,
          ),
          const SizedBox(
            height: 32,
          ),
          Align(
            alignment: Alignment.center,
            child: _YoilGraph(days: days),
          )
        ],
      ),
    );
  }
}

class _YoilGraph extends StatelessWidget {
  final List<ResponseBioReportDaysModel> days;

  const _YoilGraph({
    Key? key,
    required this.days,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final yoilData = [];

    for (var element in days) {
      if (element.day == "Mon"){
        yoilData.add(Pair(getAppLocalizations(context).common_monday, element.steps ?? 0));
      }else if (element.day == "Tue") {
        yoilData.add(Pair(getAppLocalizations(context).common_tuesday, element.steps ?? 0));
      }else if (element.day == "Wed") {
        yoilData.add(Pair(getAppLocalizations(context).common_wednesday, element.steps ?? 0));
      }else if (element.day == "Thu") {
        yoilData.add(Pair(getAppLocalizations(context).common_thursday, element.steps ?? 0));
      }else if (element.day == "Fri") {
        yoilData.add(Pair(getAppLocalizations(context).common_friday, element.steps ?? 0));
      }else if (element.day == "Sat") {
        yoilData.add(Pair(getAppLocalizations(context).common_saturday, element.steps ?? 0));
      }else if (element.day == "Sun") {
        yoilData.add(Pair(getAppLocalizations(context).common_sunday, element.steps ?? 0));
      }
    }


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
                          DateChecker.isTodayCheckFromKrYoil(e.first) ? 1 : 0.1,
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
                      color: DateChecker.isTodayCheckFromKrYoil(e.first)
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
