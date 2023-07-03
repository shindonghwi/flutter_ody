import 'package:flutter/material.dart';
import 'package:ody_flutter_app/presentation/features/analysis/widget/AnalysisItemTitle.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';
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
          SizedBox(
            height: 32,
          ),
          Align(
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
      child: Column(
        children: [
          Container(
            height: 90,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: yoilData.map((e) {
                return Column(
                  children: [
                    Container(
                      width: 14,
                    )
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
