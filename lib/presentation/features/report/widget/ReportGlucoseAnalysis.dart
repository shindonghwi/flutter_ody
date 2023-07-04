import 'package:flutter/material.dart';
import 'package:ody_flutter_app/presentation/components/progress/PainterLinearHorizontalProgress.dart';
import 'package:ody_flutter_app/presentation/features/analysis/widget/AnalysisItemTitle.dart';
import 'package:ody_flutter_app/presentation/ui/colors.dart';
import 'package:ody_flutter_app/presentation/ui/typography.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';
import 'package:ody_flutter_app/presentation/utils/dto/Pair.dart';
import 'package:ody_flutter_app/presentation/utils/dto/Triple.dart';

class ReportGlucoseAnalysis extends StatelessWidget {
  const ReportGlucoseAnalysis({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Pair<String, int>> analysisItems = [
      Pair(
        getAppLocalizations(context).record_range_figure_normal,
        0,
      ),
      Pair(
        getAppLocalizations(context).record_range_figure_warning,
        13,
      ),
      Pair(
        getAppLocalizations(context).record_range_figure_danger,
        4,
      ),
    ];

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: Column(
        children: [
          AnalysisItemTitle(
            title: getAppLocalizations(context).report_glucose_weekly_analysis_subtitle,
            secondTitle: Triple(
                getAppLocalizations(context).report_glucose_monthly_analysis_text1,
                getAppLocalizations(context).analysis_blood_pressure_average_measure_text_unit(17),
                getAppLocalizations(context).report_glucose_monthly_analysis_text2),
            description: getAppLocalizations(context).report_glucose_monthly_analysis_description,
          ),
          const SizedBox(
            height: 40,
          ),
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(0),
            shrinkWrap: true,
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(height: 24); // Adjust the height as needed
            },
            itemBuilder: (BuildContext context, int index) {
              final item = analysisItems[index];
              return Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 16,
                    fit: FlexFit.tight,
                    child: Text(
                      item.first,
                      style: getTextTheme(context).c3m.copyWith(
                            color: getColorScheme(context).neutral70,
                          ),
                    ),
                  ),
                  Flexible(
                    flex: 68,
                    fit: FlexFit.tight,
                    child: SizedBox(
                      width: double.infinity,
                      height: 16,
                      child: CustomPaint(
                        painter: PainterLinearHorizontalProgress(
                          progress: item.second / 30,
                          defaultColor: getColorScheme(context).colorPrimaryDisable.withOpacity(0.3),
                          activeColor: index == 0
                              ? getColorScheme(context).primary100
                              : index == 1
                                  ? getColorScheme(context).error40
                                  : getColorScheme(context).colorError,
                          radius: 100,
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 16,
                    fit: FlexFit.tight,
                    child: Text(
                      "${(item.second).toInt()}${getAppLocalizations(context).common_count}",
                      style: getTextTheme(context).c3b.copyWith(
                            color: index == 0
                                ? getColorScheme(context).primary100
                                : index == 1
                                    ? getColorScheme(context).error40
                                    : getColorScheme(context).colorError,
                          ),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              );
            },
            itemCount: analysisItems.length,
          ),
        ],
      ),
    );
  }
}
