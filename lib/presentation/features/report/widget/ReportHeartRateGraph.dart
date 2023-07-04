import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ody_flutter_app/presentation/components/graph/RecordGraph.dart';
import 'package:ody_flutter_app/presentation/components/graph/model/AxisEmphasisModel.dart';
import 'package:ody_flutter_app/presentation/components/graph/model/GraphLineModel.dart';
import 'package:ody_flutter_app/presentation/components/graph/model/GraphPointModel.dart';
import 'package:ody_flutter_app/presentation/components/graph/model/ShadowAreaModel.dart';
import 'package:ody_flutter_app/presentation/components/graph/widget/SymbolWidget.dart';
import 'package:ody_flutter_app/presentation/features/analysis/widget/AnalysisItemTitle.dart';
import 'package:ody_flutter_app/presentation/ui/colors.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';
import 'package:ody_flutter_app/presentation/utils/date/DateChecker.dart';
import 'package:ody_flutter_app/presentation/utils/dto/Triple.dart';

class ReportHeartRateGraph extends StatelessWidget {
  const ReportHeartRateGraph({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sampleXAxisList = [
      AxisEmphasisModel(label: "월", color: getColorScheme(context).neutral60),
      AxisEmphasisModel(label: "화", color: getColorScheme(context).neutral60),
      AxisEmphasisModel(label: "수", color: getColorScheme(context).neutral60),
      AxisEmphasisModel(label: "목", color: getColorScheme(context).neutral60),
      AxisEmphasisModel(label: "금", color: getColorScheme(context).neutral60),
      AxisEmphasisModel(label: "토", color: getColorScheme(context).neutral60),
      AxisEmphasisModel(label: "일", color: getColorScheme(context).neutral60),
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
        pointData: [
          GraphPointDataModel(
            label: "월",
            yValue: 60,
            pointColor: DateChecker.isTodayCheckFromYoil("월")
                ? getColorScheme(context).secondary100
                : getColorScheme(context).secondary20,
          ),
          GraphPointDataModel(
            label: "화",
            yValue: 70,
            pointColor: DateChecker.isTodayCheckFromYoil("화")
                ? getColorScheme(context).secondary100
                : getColorScheme(context).secondary20,
          ),
          GraphPointDataModel(
            label: "수",
            yValue: 90,
            pointColor: DateChecker.isTodayCheckFromYoil("수")
                ? getColorScheme(context).secondary100
                : getColorScheme(context).secondary20,
          ),
          GraphPointDataModel(
            label: "목",
            yValue: 140,
            pointColor: DateChecker.isTodayCheckFromYoil("목")
                ? getColorScheme(context).secondary100
                : getColorScheme(context).secondary20,
          ),
          GraphPointDataModel(
            label: "금",
            yValue: 120,
            pointColor: DateChecker.isTodayCheckFromYoil("금")
                ? getColorScheme(context).secondary100
                : getColorScheme(context).secondary20,
          ),
          GraphPointDataModel(
            label: "토",
            yValue: 130,
            pointColor: DateChecker.isTodayCheckFromYoil("토")
                ? getColorScheme(context).secondary100
                : getColorScheme(context).secondary20,
          ),
          GraphPointDataModel(
            label: "일",
            yValue: 110,
            pointColor: DateChecker.isTodayCheckFromYoil("일")
                ? getColorScheme(context).secondary100
                : getColorScheme(context).secondary20,
          ),
        ],
        lineColor: getColorScheme(context).secondary20,
      ),
    ];

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          AnalysisItemTitle(
            title: getAppLocalizations(context).report_heart_rate_subtitle,
            secondTitle: Triple(
                getAppLocalizations(context).report_heart_rate_text1,
                "${66} ${getAppLocalizations(context).common_count_per_minute}",
                getAppLocalizations(context).report_heart_rate_text2),
            description: getAppLocalizations(context).report_heart_rate_description,
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
