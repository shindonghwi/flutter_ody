import 'package:flutter/material.dart';
import 'package:ody_flutter_app/presentation/features/analysis/widget/AnalysisItemTitle.dart';
import 'package:ody_flutter_app/presentation/ui/colors.dart';
import 'package:ody_flutter_app/presentation/ui/typography.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';
import 'package:ody_flutter_app/presentation/utils/dto/Pair.dart';
import 'package:ody_flutter_app/presentation/utils/dto/Triple.dart';

class GlucoseRecordAnalysis extends StatelessWidget {
  final int count;
  final int sumNormal;
  final int sumWarn;
  final int sumAlert;

  const GlucoseRecordAnalysis({
    super.key,
    required this.count,
    required this.sumNormal,
    required this.sumWarn,
    required this.sumAlert,
  });

  @override
  Widget build(BuildContext context) {
    debugPrint('GlucoseRecordAnalysis: count: $count, sumNormal: $sumNormal, sumWarn: $sumWarn, sumAlert: $sumAlert');

    final List<Pair<String, int>> analysisItems = [
      Pair(getAppLocalizations(context).record_range_figure_normal, sumNormal),
      Pair(getAppLocalizations(context).record_range_figure_warning, sumWarn),
      Pair(getAppLocalizations(context).record_range_figure_danger, sumAlert),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        AnalysisItemTitle(
          title: getAppLocalizations(context).analysis_glucose_record_measure_title,
          secondTitle: Triple(
            getAppLocalizations(context).analysis_glucose_record_measure_text1,
            getAppLocalizations(context).analysis_glucose_record_range_text_unit(count),
            getAppLocalizations(context).analysis_glucose_record_measure_text2,
          ),
          description: getAppLocalizations(context).analysis_glucose_record_measure_description,
        ),
        const SizedBox(
          height: 40,
        ),
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(0),
          shrinkWrap: true,
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(height: 16); // Adjust the height as needed
          },
          itemBuilder: (BuildContext context, int index) {
            final item = analysisItems[index];
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 3,
                  fit: FlexFit.tight,
                  child: Text(
                    item.first,
                    style: getTextTheme(context).c3m.copyWith(
                          color: getColorScheme(context).neutral70,
                        ),
                  ),
                ),
                Flexible(
                  flex: 13,
                  fit: FlexFit.tight,
                  child: Stack(
                    children: [
                      Container(
                        height: 16,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              index == 0
                                  ? getColorScheme(context).primary100
                                  : index == 1
                                      ? getColorScheme(context).error40
                                      : getColorScheme(context).colorError,
                              getColorScheme(context).colorPrimaryDisable,
                            ],
                            stops: [(item.second / count).toDouble(), (item.second / count).toDouble()],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.circular(100.0),
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  flex: 4,
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
    );
  }
}
