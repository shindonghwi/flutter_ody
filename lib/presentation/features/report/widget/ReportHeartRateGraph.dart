import 'package:flutter/material.dart';
import 'package:ody_flutter_app/data/models/bio/ResponseBioReportDaysModel.dart';
import 'package:ody_flutter_app/presentation/components/graph/RecordGraph.dart';
import 'package:ody_flutter_app/presentation/components/graph/model/AxisEmphasisModel.dart';
import 'package:ody_flutter_app/presentation/components/graph/model/GraphLineModel.dart';
import 'package:ody_flutter_app/presentation/components/graph/model/GraphPointModel.dart';
import 'package:ody_flutter_app/presentation/components/graph/model/ShadowAreaModel.dart';
import 'package:ody_flutter_app/presentation/features/analysis/widget/AnalysisItemTitle.dart';
import 'package:ody_flutter_app/presentation/ui/colors.dart';
import 'package:ody_flutter_app/presentation/utils/CollectionUtil.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';
import 'package:ody_flutter_app/presentation/utils/date/DateChecker.dart';
import 'package:ody_flutter_app/presentation/utils/date/DateTransfer.dart';
import 'package:ody_flutter_app/presentation/utils/dto/Pair.dart';
import 'package:ody_flutter_app/presentation/utils/dto/Triple.dart';

class ReportHeartRateGraph extends StatelessWidget {
  final List<ResponseBioReportDaysModel>? days;

  const ReportHeartRateGraph({
    Key? key,
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
        min: 70,
        max: 75,
        color: getColorScheme(context).secondary100.withOpacity(0.05),
      ),
    ];

    days?.sort((a, b) {
      int indexA = DateTransfer.enYoilList.indexOf(a.day.toString());
      int indexB = DateTransfer.enYoilList.indexOf(b.day.toString());
      return indexA - indexB;
    });

    final heartRateList = days
        ?.map((e) => Pair(
              DateTransfer.convertShortYoilEnToKr(e.day.toString()),
              e.heartRate,
            ))
        .toList();

    final List<GraphLineModel> graphLineModelList = [];

    if (!CollectionUtil.isNullorEmpty(heartRateList)) {
      graphLineModelList.add(GraphLineModel(
        pointData: heartRateList!.map((e) {
          return GraphPointDataModel(
              label: e.first,
              yValue: (e.second ?? 0).toDouble(),
              pointColor: DateChecker.isTodayCheckFromKrYoil(e.first)
                  ? getColorScheme(context).secondary100
                  : getColorScheme(context).secondary20);
        }).toList(),
        lineColor: getColorScheme(context).secondary20,
      ));
    }

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
                  xAxisList: xAxisList,
                  yAxisList: sampleYAxisList,
                  shadowAreaList: shadowAreaList,
                  symbolWidget: null,
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
