import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ody_flutter_app/data/models/bio/ResponseBioReportDaysModel.dart';
import 'package:ody_flutter_app/presentation/components/graph/RecordGraph.dart';
import 'package:ody_flutter_app/presentation/components/graph/model/AxisEmphasisModel.dart';
import 'package:ody_flutter_app/presentation/components/graph/model/GraphLineModel.dart';
import 'package:ody_flutter_app/presentation/components/graph/model/GraphPointModel.dart';
import 'package:ody_flutter_app/presentation/components/graph/model/ShadowAreaModel.dart';
import 'package:ody_flutter_app/presentation/components/graph/widget/SymbolWidget.dart';
import 'package:ody_flutter_app/presentation/features/analysis/widget/AnalysisItemTitle.dart';
import 'package:ody_flutter_app/presentation/ui/colors.dart';
import 'package:ody_flutter_app/presentation/utils/CollectionUtil.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';
import 'package:ody_flutter_app/presentation/utils/date/DateChecker.dart';
import 'package:ody_flutter_app/presentation/utils/date/DateTransfer.dart';
import 'package:ody_flutter_app/presentation/utils/dto/Pair.dart';
import 'package:ody_flutter_app/presentation/utils/dto/Triple.dart';

class ReportBloodPressureGraph extends StatelessWidget {
  final bool isWeekly;
  final List<ResponseBioReportDaysModel>? days;

  const ReportBloodPressureGraph({
    Key? key,
    required this.isWeekly,
    required this.days,
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

    final shadowAreaList = [
      ShadowAreaModel(
        min: 90,
        max: 120,
        color: getColorScheme(context).colorError.withOpacity(0.05),
      ),
      ShadowAreaModel(
        min: 60,
        max: 80,
        color: getColorScheme(context).colorPrimaryFocus.withOpacity(0.05),
      ),
    ];

    days?.sort((a, b) {
      int indexA = DateTransfer.enYoilList.indexOf(a.day.toString());
      int indexB = DateTransfer.enYoilList.indexOf(b.day.toString());
      return indexA - indexB;
    });

    final systolicList = days
        ?.map((e) => Pair(
              DateTransfer.convertShortYoilEnToKr(e.day.toString()),
              e.systolic,
            ))
        .toList();
    final diastolicList = days
        ?.map((e) => Pair(
              DateTransfer.convertShortYoilEnToKr(e.day.toString()),
              e.diastolic,
            ))
        .toList();

    final List<GraphLineModel> graphLineModelList = [];

    if (!CollectionUtil.isNullorEmpty(systolicList)) {
      graphLineModelList.add(GraphLineModel(
        pointData: systolicList!.map((e) {
          return GraphPointDataModel(
              label: e.first,
              yValue: (e.second ?? 0).toDouble(),
              pointColor: DateChecker.isTodayCheckFromKrYoil(e.first)
                  ? getColorScheme(context).colorError
                  : getColorScheme(context).error20);
        }).toList(),
        lineColor: getColorScheme(context).error20,
      ));
    }
    if (!CollectionUtil.isNullorEmpty(diastolicList)) {
      graphLineModelList.add(GraphLineModel(
        pointData: diastolicList!.map((e) {
          return GraphPointDataModel(
              label: e.first,
              yValue: (e.second ?? 0).toDouble(),
              pointColor: DateChecker.isTodayCheckFromKrYoil(e.first)
                  ? getColorScheme(context).primary100
                  : getColorScheme(context).primary20);
        }).toList(),
        lineColor: getColorScheme(context).primary20,
      ));
    }

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          AnalysisItemTitle(
            title: getAppLocalizations(context).report_blood_pressure_weekly_analysis_subtitle,
            secondTitle: Triple(
                getAppLocalizations(context).report_blood_pressure_graph_text1,
                "${110} - ${100} ${getAppLocalizations(context).record_blood_pressure_input1_unit}",
                getAppLocalizations(context).report_blood_pressure_graph_text2),
            description: getAppLocalizations(context).report_blood_pressure_weekly_description,
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
                child: RecordGraph.line(
                  xAxisList: xAxisList,
                  yAxisList: sampleYAxisList,
                  shadowAreaList: shadowAreaList,
                  symbolWidget: const _SymbolList(),
                  xAxisInnerHorizontalPadding: 0,
                  dividerColor: getColorScheme(context).neutral50,
                  graphLineModelList: graphLineModelList,
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
          label: getAppLocalizations(context).analysis_blood_pressure_figure_symbol_systolic,
          color: getColorScheme(context).colorError,
        ),
        const SizedBox(
          width: 16,
        ),
        SymbolWidget(
          label: getAppLocalizations(context).analysis_blood_pressure_figure_symbol_diastolic,
          color: getColorScheme(context).colorPrimaryFocus,
        ),
      ],
    );
  }
}
