import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ody_flutter_app/data/models/bio/ResponseBioGlucoseModel.dart';
import 'package:ody_flutter_app/presentation/components/graph/RecordGraph.dart';
import 'package:ody_flutter_app/presentation/components/graph/model/AxisEmphasisModel.dart';
import 'package:ody_flutter_app/presentation/components/graph/model/GraphPointModel.dart';
import 'package:ody_flutter_app/presentation/components/graph/widget/SymbolWidget.dart';
import 'package:ody_flutter_app/presentation/features/analysis/widget/AnalysisItemTitle.dart';
import 'package:ody_flutter_app/presentation/features/record/model/RecordRangeStatus.dart';
import 'package:ody_flutter_app/presentation/ui/colors.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';
import 'package:ody_flutter_app/presentation/utils/dto/Triple.dart';

class GlucoseFigure extends StatelessWidget {
  final List<ResponseBioGlucoseModel>? glucoseList;

  const GlucoseFigure({
    Key? key,
    required this.glucoseList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sampleXAxisList = [
      AxisEmphasisModel(label: "00:00", color: getColorScheme(context).neutral60),
      AxisEmphasisModel(label: "06:00", color: getColorScheme(context).neutral60),
      AxisEmphasisModel(label: "12:00", color: getColorScheme(context).neutral60),
      AxisEmphasisModel(label: "18:00", color: getColorScheme(context).neutral60),
      AxisEmphasisModel(label: "24:00", color: getColorScheme(context).neutral60),
    ];

    final sampleYAxisList = [
      AxisEmphasisModel(label: "60", color: getColorScheme(context).neutral60),
      AxisEmphasisModel(label: "80", color: getColorScheme(context).neutral60),
      AxisEmphasisModel(label: "100", color: getColorScheme(context).neutral60),
      AxisEmphasisModel(label: "120", color: getColorScheme(context).neutral60),
      AxisEmphasisModel(label: "140", color: getColorScheme(context).neutral60),
      AxisEmphasisModel(label: "160", color: getColorScheme(context).neutral60),
    ].reversed.toList();

    final sampleGraphPointList = GraphPointModel(
      pointData: glucoseList?.map((e) =>
          GraphPointDataModel(label: e.createdAt,
            yValue: e.glucose.toDouble(),
            pointColor: RecordRangeStatusHelper.getStatusTextColor(
              context, RecordRangeStatusHelper.getGlucoseRecordRangeStatusFromCode(e.status.code),),),).toList() ??
          [],);

    int? smallestLabel = glucoseList
        ?.map((e) => e.glucose)
        .reduce((current, next) => current.compareTo(next) < 0 ? current : next);

    int? largestLabel = glucoseList
        ?.map((e) => e.glucose)
        .reduce((current, next) => current.compareTo(next) > 0 ? current : next);


    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        AnalysisItemTitle(
          title: getAppLocalizations(context).analysis_glucose_figure_title,
          secondTitle: Triple(
            getAppLocalizations(context).analysis_glucose_figure_text1,
            "$smallestLabel - $largestLabel ${getAppLocalizations(context).record_glucose_input_unit}",
            getAppLocalizations(context).analysis_glucose_figure_text2,
          ),
          description: getAppLocalizations(context).analysis_glucose_figure_description,
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
                xAxisList: sampleXAxisList,
                yAxisList: sampleYAxisList,
                shadowAreaList: [],
                symbolWidget: const _SymbolList(),
                xAxisInnerHorizontalPadding: 0,
                dividerColor: getColorScheme(context).neutral50,
                graphPointModel: sampleGraphPointList,
              ),
            )
          ],
        ),
      ],
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
