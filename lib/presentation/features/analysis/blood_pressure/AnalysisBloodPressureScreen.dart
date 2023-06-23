import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ody_flutter_app/presentation/components/graph/RecordGraph.dart';
import 'package:ody_flutter_app/presentation/components/graph/model/AxisEmphasisModel.dart';
import 'package:ody_flutter_app/presentation/components/graph/model/GraphLineModel.dart';
import 'package:ody_flutter_app/presentation/components/graph/model/GraphPointModel.dart';
import 'package:ody_flutter_app/presentation/components/graph/model/ShadowAreaModel.dart';
import 'package:ody_flutter_app/presentation/components/graph/widget/SymbolWidget.dart';
import 'package:ody_flutter_app/presentation/ui/colors.dart';
import 'package:ody_flutter_app/presentation/ui/typography.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';

class AnalysisBloodPressureScreen extends StatelessWidget {
  const AnalysisBloodPressureScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sampleXAxisList = [
      AxisEmphasisModel(label: "1주", color: getColorScheme(context).neutral60),
      AxisEmphasisModel(label: "2주", color: getColorScheme(context).colorPrimaryFocus),
      AxisEmphasisModel(label: "3주", color: getColorScheme(context).neutral60),
      AxisEmphasisModel(label: "4주", color: getColorScheme(context).colorError),
      AxisEmphasisModel(label: "5주", color: getColorScheme(context).neutral60),
      AxisEmphasisModel(label: "6주", color: getColorScheme(context).neutral60),
      AxisEmphasisModel(label: "7주", color: getColorScheme(context).neutral60)
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

    final sampleGraphLineModel = GraphLineModel(
      pointData: [
        GraphPointDataModel(
          label: "1주",
          yValue: Random().nextInt(100) + 60.toDouble(),
          pointColor: getColorScheme(context).error20,
        ),
        GraphPointDataModel(
          label: "3주",
          yValue: Random().nextInt(100) + 60.toDouble(),
          pointColor: getColorScheme(context).colorError,
        ),
        GraphPointDataModel(
          label: "5주",
          yValue: Random().nextInt(100) + 60.toDouble(),
          pointColor: getColorScheme(context).error20,
        )
      ],
      lineColor: getColorScheme(context).error20,
    );

    final sampleGraphPointList = GraphPointModel(
        pointData: List.generate(81, (index) {
      return GraphPointDataModel(
        label: "${Random().nextInt(7) + 1}주",
        yValue: Random().nextInt(100) + 60.toDouble(),
        pointColor: index % 3 == 0
            ? getColorScheme(context).colorPrimaryFocus
            : getColorScheme(context).colorError,
      );
    }));

    return Scaffold(
      backgroundColor: getColorScheme(context).colorUI02,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 26),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "맥박 수치",
                    style: getTextTheme(context).b3sb.copyWith(
                          color: getColorScheme(context).colorPrimaryFocus,
                        ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "최근 맥박은 ",
                          style: getTextTheme(context).t2b.copyWith(
                                color: getColorScheme(context).colorText,
                              ),
                        ),
                        TextSpan(
                          text: "66 회/분 ",
                          style: getTextTheme(context).t2b.copyWith(
                                color: getColorScheme(context).colorPrimaryFocus,
                              ),
                        ),
                        TextSpan(
                          text: "입니다",
                          style: getTextTheme(context).t2b.copyWith(
                                color: getColorScheme(context).colorText,
                              ),
                        ),
                      ],
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    "정상 맥박범위는 성인 기준 70~75회/분 입니다",
                    style: getTextTheme(context).c2r.copyWith(
                          color: getColorScheme(context).neutral60,
                        ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  SizedBox(
                    width: getMediaQuery(context).size.width,
                    height: getMediaQuery(context).size.width * 0.7,
                    child: RecordGraph.line(
                      xAxisList: sampleXAxisList,
                      yAxisList: sampleYAxisList,
                      shadowAreaList: shadowAreaList,
                      symbolWidget: const _SymbolList(),
                      xAxisInnerHorizontalPadding: 40,
                      dividerColor: getColorScheme(context).neutral50,
                      xAxisUnitWidth: 15,
                      // graphPointModel: sampleGraphPointList,
                      graphLineModel: sampleGraphLineModel,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
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
          label: "정상",
          color: getColorScheme(context).colorPrimaryFocus,
        ),
        const SizedBox(
          width: 16,
        ),
        SymbolWidget(
          label: "주의",
          color: getColorScheme(context).error40,
        ),
        const SizedBox(
          width: 16,
        ),
        SymbolWidget(
          label: "위험",
          color: getColorScheme(context).colorError,
        ),
      ],
    );
  }
}
