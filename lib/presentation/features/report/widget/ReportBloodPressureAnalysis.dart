import 'package:flutter/material.dart';
import 'package:ody_flutter_app/data/models/bio/ResponseBioReportStatesModel.dart';
import 'package:ody_flutter_app/presentation/components/progress/PainterLinearHorizontalProgress.dart';
import 'package:ody_flutter_app/presentation/features/analysis/widget/AnalysisItemTitle.dart';
import 'package:ody_flutter_app/presentation/features/record/model/RecordRangeStatus.dart';
import 'package:ody_flutter_app/presentation/ui/colors.dart';
import 'package:ody_flutter_app/presentation/ui/typography.dart';
import 'package:ody_flutter_app/presentation/utils/CollectionUtil.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';
import 'package:ody_flutter_app/presentation/utils/dto/Triple.dart';
import 'package:ody_flutter_app/presentation/utils/regex/RegexUtil.dart';

class ReportBloodPressureAnalysis extends StatelessWidget {
  final int totalCount;
  final List<ResponseBioReportStatesModel>? states;

  const ReportBloodPressureAnalysis({
    Key? key,
    required this.totalCount,
    required this.states,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Triple> analysisItems = [];
    states?.map((e) {
      if (CollectionUtil.isEqualLowerCase(e.state.toString(), RecordRangeStatus.HighRisk.name)) {
        analysisItems.add(Triple(getAppLocalizations(context).record_range_figure_danger, e.count, e.state));
      } else if (CollectionUtil.isEqualLowerCase(e.state.toString(), RecordRangeStatus.Normal.name)) {
        analysisItems.add(Triple(getAppLocalizations(context).record_range_figure_normal, e.count, e.state));
      } else if (CollectionUtil.isEqualLowerCase(e.state.toString(), RecordRangeStatus.Risk.name)) {
        analysisItems.add(Triple(getAppLocalizations(context).record_range_figure_warning, e.count, e.state));
      }
    }).toList();

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          AnalysisItemTitle(
            title: getAppLocalizations(context).report_blood_pressure_weekly_analysis_subtitle,
            secondTitle: Triple(
                getAppLocalizations(context).report_blood_pressure_weekly_analysis_text1,
                getAppLocalizations(context)
                    .analysis_blood_pressure_average_measure_text_unit(RegexUtil.commaNumber(totalCount)),
                getAppLocalizations(context).report_blood_pressure_weekly_analysis_text2),
            description: getAppLocalizations(context).report_blood_pressure_analysis_description,
          ),
          const SizedBox(
            height: 40,
          ),
          CollectionUtil.isNullorEmpty(analysisItems)
              ? const SizedBox()
              : ListView.separated(
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
                                activeColor: RecordRangeStatusHelper.getStatusTextColor(
                                  context,
                                  RecordRangeStatusHelper.getBPRecordRangeStatusFromCode(item.third),
                                ),
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
                                  color: RecordRangeStatusHelper.getStatusTextColor(
                                    context,
                                    RecordRangeStatusHelper.getBPRecordRangeStatusFromCode(item.third),
                                  ),
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
