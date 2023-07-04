import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ody_flutter_app/data/models/bio/ResponseBioReportDaysModel.dart';
import 'package:ody_flutter_app/presentation/components/graph/RecordGraph.dart';
import 'package:ody_flutter_app/presentation/components/graph/model/AxisEmphasisModel.dart';
import 'package:ody_flutter_app/presentation/components/graph/model/GraphPointModel.dart';
import 'package:ody_flutter_app/presentation/components/graph/widget/SymbolWidget.dart';
import 'package:ody_flutter_app/presentation/features/analysis/widget/AnalysisItemTitle.dart';
import 'package:ody_flutter_app/presentation/features/record/model/RecordRangeStatus.dart';
import 'package:ody_flutter_app/presentation/ui/colors.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';
import 'package:ody_flutter_app/presentation/utils/date/DateChecker.dart';
import 'package:ody_flutter_app/presentation/utils/date/DateTransfer.dart';
import 'package:ody_flutter_app/presentation/utils/dto/Triple.dart';

class ReportGlucoseGraph extends StatelessWidget {
  final int minFastingGlucose;
  final int maxFastingGlucose;
  final List<ResponseBioReportDaysModel> days;

  const ReportGlucoseGraph({
    Key? key,
    required this.days,
    required this.minFastingGlucose,
    required this.maxFastingGlucose,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final xAxisList = DateTransfer.krYoilList.map((e) {
      return AxisEmphasisModel(
        label: e,
        color: DateChecker.isTodayCheckFromKrYoil(e)
            ? getColorScheme(context).primary100
            : getColorScheme(context).neutral60,
      );
    }).toList();

    final sampleYAxisList = [
      AxisEmphasisModel(label: "60", color: getColorScheme(context).neutral60),
      AxisEmphasisModel(label: "80", color: getColorScheme(context).neutral60),
      AxisEmphasisModel(label: "100", color: getColorScheme(context).neutral60),
      AxisEmphasisModel(label: "120", color: getColorScheme(context).neutral60),
      AxisEmphasisModel(label: "140", color: getColorScheme(context).neutral60),
      AxisEmphasisModel(label: "160", color: getColorScheme(context).neutral60),
    ].reversed.toList();

    days.sort((a, b) {
      int indexA = DateTransfer.enYoilList.indexOf(a.day.toString());
      int indexB = DateTransfer.enYoilList.indexOf(b.day.toString());
      return indexA - indexB;
    });

    final glucoseList = days
        .map((e) => Triple(
              DateTransfer.convertShortYoilEnToKr(e.day.toString()),
              e.glucose,
              e.state,
            ))
        .toList();

    final graphPointModelList = GraphPointModel(
      pointData: glucoseList.map((e) {
        return GraphPointDataModel(
          label: e.first,
          yValue: (e.second ?? 0).toDouble(),
          pointColor: RecordRangeStatusHelper.getStatusTextColor(
            context,
            RecordRangeStatusHelper.getGlucoseRecordRangeStatusFromCode(e.third.toString()),
          ),
        );
      }).toList(),
    );

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          AnalysisItemTitle(
            title: getAppLocalizations(context).report_glucose_weekly_graph_subtitle,
            secondTitle: Triple(
                getAppLocalizations(context).report_glucose_weekly_graph_text1,
                "$minFastingGlucose - $maxFastingGlucose ${getAppLocalizations(context).record_blood_pressure_input1_unit}",
                getAppLocalizations(context).report_glucose_weekly_graph_text2),
            description: getAppLocalizations(context).report_glucose_weekly_graph_description,
          ),
          const SizedBox(
            height: 40,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: getMediaQuery(context).size.width,
                height: getMediaQuery(context).size.width * 0.6,
                child: RecordGraph.point(
                  xAxisList: xAxisList,
                  yAxisList: sampleYAxisList,
                  shadowAreaList: [],
                  symbolWidget: const _SymbolList(),
                  xAxisInnerHorizontalPadding: 0,
                  dividerColor: getColorScheme(context).neutral50,
                  graphPointModel: graphPointModelList,
                  xAxisType: RecordXAxisType.YOIL,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class _SymbolList extends HookWidget {
  const _SymbolList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SymbolWidget(
          label: getAppLocalizations(context).record_range_figure_normal,
          color: getColorScheme(context).colorPrimaryFocus,
        ),
        const SizedBox(
          width: 16,
        ),
        SymbolWidget(
          label: getAppLocalizations(context).record_range_figure_warning,
          color: getColorScheme(context).error40,
        ),
        const SizedBox(
          width: 16,
        ),
        SymbolWidget(
          label: getAppLocalizations(context).record_range_figure_danger,
          color: getColorScheme(context).colorError,
        ),
      ],
    );
  }
}
