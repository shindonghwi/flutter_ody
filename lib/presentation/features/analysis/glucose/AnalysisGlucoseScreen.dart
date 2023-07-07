import 'package:flutter/material.dart';
import 'package:ody_flutter_app/data/models/bio/ResponseBioGlucoseModel.dart';
import 'package:ody_flutter_app/domain/models/bio/GlucoseMesaureType.dart';
import 'package:ody_flutter_app/presentation/components/appbar/IconTitleIconAppBar.dart';
import 'package:ody_flutter_app/presentation/components/appbar/model/AppBarIcon.dart';
import 'package:ody_flutter_app/presentation/components/divider/DottedDivider.dart';
import 'package:ody_flutter_app/presentation/features/analysis/glucose/widget/AverageGlucose.dart';
import 'package:ody_flutter_app/presentation/features/analysis/glucose/widget/GlucoseFigure.dart';
import 'package:ody_flutter_app/presentation/features/analysis/glucose/widget/GlucoseRecordAnalysis.dart';
import 'package:ody_flutter_app/presentation/features/record/model/RecordRangeStatus.dart';
import 'package:ody_flutter_app/presentation/ui/colors.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';
import 'package:ody_flutter_app/presentation/utils/dto/Triple.dart';

class AnalysisGlucoseScreen extends StatelessWidget {
  final List<ResponseBioGlucoseModel>? glucoseList;

  const AnalysisGlucoseScreen({
    Key? key,
    this.glucoseList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final int totalCount = glucoseList?.length ?? 0;
    int sumGlucose = 0;
    int sumFasting = 0; // 공복
    int sumPreprandial = 0; // 식전,
    int sumPostprandial = 0; // 식후,
    int sumPostExercise = 0; // 운동후,
    int sumNormal = 0;
    int sumWarn = 0;
    int sumAlert = 0;

    glucoseList?.forEach((element) {
      sumGlucose += element.glucose;
      sumFasting +=
          element.type.code.toLowerCase() == GlucoseMeasureType.Fasting.name.toLowerCase() ? element.glucose : 0;
      sumPreprandial +=
          element.type.code.toLowerCase() == GlucoseMeasureType.Preprandial.name.toLowerCase() ? element.glucose : 0;
      sumPostprandial +=
          element.type.code.toLowerCase() == GlucoseMeasureType.Postprandial.name.toLowerCase() ? element.glucose : 0;
      sumPostExercise +=
          element.type.code.toLowerCase() == GlucoseMeasureType.PostExercise.name.toLowerCase() ? element.glucose : 0;

      if (RecordRangeStatusHelper.getGlucoseRecordRangeStatusFromCode(element.status.code) ==
          RecordRangeStatus.Normal) {
        sumNormal += 1;
      } else if (RecordRangeStatusHelper.getGlucoseRecordRangeStatusFromCode(element.status.code) ==
          RecordRangeStatus.Warn) {
        sumWarn += 1;
      } else if (RecordRangeStatusHelper.getGlucoseRecordRangeStatusFromCode(element.status.code) ==
          RecordRangeStatus.Alert) {
        sumAlert += 1;
      }
    });

    return Scaffold(
      backgroundColor: getColorScheme(context).colorUI02,
      appBar: IconTitleIconAppBar(
        leadingIcon: AppBarIcon(
          path: 'assets/imgs/icon_back.svg',
          onPressed: () => Navigator.of(context).pop(),
          tint: getColorScheme(context).colorText,
        ),
        title: getAppLocalizations(context).analysis_glucose_title,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          padding: const EdgeInsets.fromLTRB(40, 24, 40, 64),
          child: Column(
            children: [
              AverageGlucose(
                title: getAppLocalizations(context).analysis_glucose_record_range,
                secondTitle: Triple(
                  getAppLocalizations(context).analysis_glucose_record_range_text1,
                  getAppLocalizations(context).analysis_glucose_record_range_text_unit(glucoseList?.length ?? 0),
                  getAppLocalizations(context).analysis_glucose_record_range_text2,
                ),
                description: getAppLocalizations(context).analysis_glucose_record_range_description,
                averageFasting: (sumFasting / totalCount).round(),
                averagePreprandial: (sumPreprandial / totalCount).round(),
                averagePostprandial: (sumPostprandial / totalCount).round(),
                averagePostExercise: (sumPostExercise / totalCount).round(),
              ),
              const DottedDivider(margin: EdgeInsets.symmetric(vertical: 40)),
              GlucoseRecordAnalysis(
                count: glucoseList?.length ?? 0,
                sumNormal: sumNormal,
                sumWarn: sumWarn,
                sumAlert: sumAlert,
              ),
              const DottedDivider(margin: EdgeInsets.symmetric(vertical: 40)),
              GlucoseFigure(
                glucoseList: glucoseList,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
