import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ody_flutter_app/data/models/bio/ResponseBioBloodPressureModel.dart';
import 'package:ody_flutter_app/presentation/components/graph/RecordGraph.dart';
import 'package:ody_flutter_app/presentation/components/graph/model/AxisEmphasisModel.dart';
import 'package:ody_flutter_app/presentation/components/graph/model/GraphLineModel.dart';
import 'package:ody_flutter_app/presentation/components/graph/model/GraphPointModel.dart';
import 'package:ody_flutter_app/presentation/components/graph/model/ShadowAreaModel.dart';
import 'package:ody_flutter_app/presentation/components/graph/widget/SymbolWidget.dart';
import 'package:ody_flutter_app/presentation/features/analysis/widget/AnalysisItemTitle.dart';
import 'package:ody_flutter_app/presentation/ui/colors.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';
import 'package:ody_flutter_app/presentation/utils/dto/Triple.dart';

class HeartRateFigure extends StatelessWidget {
  final List<ResponseBioBloodPressureModel>? bpList;

  const HeartRateFigure({
    Key? key,
    required this.bpList,
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

    final shadowAreaList = [
      ShadowAreaModel(
        min: 70,
        max: 75,
        color: getColorScheme(context).secondary100.withOpacity(0.05),
      ),
    ];

    final sampleGraphLineModelList = [
      GraphLineModel(
        pointData: bpList
            ?.map(
              (e) => GraphPointDataModel(
            label: e.createdAt,
            yValue: e.heartRate.toDouble(),
            pointColor: getColorScheme(context).secondary100,
          ),
        )
            .toList() ??
            [], lineColor: getColorScheme(context).secondary100,
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        AnalysisItemTitle(
          title: getAppLocalizations(context).analysis_heart_rate_figure_title,
          secondTitle: Triple(
            getAppLocalizations(context).analysis_heart_rate_figure_text1,
            "${bpList?.last.heartRate} ${getAppLocalizations(context).record_blood_pressure_input2_unit}",
            getAppLocalizations(context).analysis_heart_rate_figure_text2,
          ),
          description: getAppLocalizations(context).analysis_heart_rate_figure_description,
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
                xAxisList: sampleXAxisList,
                yAxisList: sampleYAxisList,
                shadowAreaList: shadowAreaList,
                symbolWidget: null,
                xAxisInnerHorizontalPadding: 0,
                dividerColor: getColorScheme(context).neutral50,
                graphLineModelList: sampleGraphLineModelList,
              ),
            )
          ],
        ),
      ],
    );
  }
}