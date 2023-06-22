import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ody_flutter_app/presentation/components/graph/RecordGraph.dart';
import 'package:ody_flutter_app/presentation/components/graph/model/AxisEmphasisModel.dart';
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
                    child: RecordGraph.point(
                      xAxisList: [
                        AxisEmphasisModel(label: "1주", color: getColorScheme(context).neutral60),
                        AxisEmphasisModel(
                            label: "2주", color: getColorScheme(context).colorPrimaryFocus),
                        AxisEmphasisModel(label: "3주", color: getColorScheme(context).neutral60),
                        AxisEmphasisModel(label: "4주", color: getColorScheme(context).neutral60),
                        AxisEmphasisModel(label: "5주", color: getColorScheme(context).neutral60)
                      ],
                      yAxisList: [
                        AxisEmphasisModel(label: "60", color: getColorScheme(context).neutral60),
                        AxisEmphasisModel(label: "80", color: getColorScheme(context).neutral60),
                        AxisEmphasisModel(label: "100", color: getColorScheme(context).neutral60),
                        AxisEmphasisModel(label: "120", color: getColorScheme(context).neutral60),
                        AxisEmphasisModel(label: "140", color: getColorScheme(context).neutral60),
                        AxisEmphasisModel(label: "160", color: getColorScheme(context).neutral60),
                      ].reversed.toList(),
                      shadowAreaList: [
                        ShadowAreaModel(
                          min: 70,
                          max: 140,
                          color: getColorScheme(context).colorPrimaryDisable.withOpacity(0.2),
                        ),
                      ],
                      symbolWidget: const _SymbolList(),
                      xAxisInnerHorizontalPadding: 40,
                      dividerColor: getColorScheme(context).neutral50,
                      xAxisUnitWidth: 15,
                      graphPointList: List.generate(81, (index) {
                        final d = Random().nextInt(100) + 60;
                        return  GraphPointModel(
                          pointX: AxisEmphasisModel(
                            label: "${Random().nextInt(5) + 1}주",
                            color: getColorScheme(context).colorPrimaryFocus,
                          ),
                          pointY: d.toDouble()
                        );
                      }).toList(),
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
