import 'package:flutter/material.dart';
import 'package:ody_flutter_app/data/models/bio/ResponseBioBloodPressureModel.dart';
import 'package:ody_flutter_app/presentation/components/appbar/IconTitleIconAppBar.dart';
import 'package:ody_flutter_app/presentation/components/appbar/model/AppBarIcon.dart';
import 'package:ody_flutter_app/presentation/components/divider/DottedDivider.dart';
import 'package:ody_flutter_app/presentation/features/analysis/blood_pressure/widget/AverageBloodPressure.dart';
import 'package:ody_flutter_app/presentation/features/analysis/blood_pressure/widget/BpFigure.dart';
import 'package:ody_flutter_app/presentation/features/analysis/blood_pressure/widget/BpRecordAnalysis.dart';
import 'package:ody_flutter_app/presentation/features/analysis/blood_pressure/widget/HeartRateFigure.dart';
import 'package:ody_flutter_app/presentation/features/record/model/RecordRangeStatus.dart';
import 'package:ody_flutter_app/presentation/ui/colors.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';
import 'package:ody_flutter_app/presentation/utils/dto/Triple.dart';

class AnalysisBloodPressureScreen extends StatelessWidget {
  final List<ResponseBioBloodPressureModel>? bpList;

  const AnalysisBloodPressureScreen({
    Key? key,
    this.bpList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final int totalCount = bpList?.length ?? 0;
    int sumSystolic = 0;
    int sumDiastolic = 0;
    int sumHeartRate = 0;
    int sumNormal = 0;
    int sumRisk = 0;
    int sumHighRisk = 0;

    bpList?.forEach((element) {
      sumSystolic += element.systolicBloodPressure;
      sumDiastolic += element.diastolicBloodPressure;
      sumHeartRate += element.heartRate;

      if (RecordRangeStatusHelper.getBPRecordRangeStatusFromCode(element.status.code) == RecordRangeStatus.Normal) {
        sumNormal += 1;
      } else if (RecordRangeStatusHelper.getBPRecordRangeStatusFromCode(element.status.code) ==
          RecordRangeStatus.Risk) {
        sumRisk += 1;
      } else if (RecordRangeStatusHelper.getBPRecordRangeStatusFromCode(element.status.code) ==
          RecordRangeStatus.HighRisk) {
        sumHighRisk += 1;
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
        title: getAppLocalizations(context).analysis_blood_pressure_title,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          padding: const EdgeInsets.fromLTRB(40, 24, 40, 64),
          child: Column(
            children: [
              AverageBloodPressure(
                title: getAppLocalizations(context).analysis_blood_pressure_average,
                secondTitle: Triple(
                  getAppLocalizations(context).analysis_blood_pressure_average_measure_text1,
                  getAppLocalizations(context).analysis_blood_pressure_average_measure_text_unit(bpList?.length ?? 0),
                  getAppLocalizations(context).analysis_blood_pressure_average_measure_text2,
                ),
                description: getAppLocalizations(context).analysis_blood_pressure_average_measure_description,
                averageSystolic: (sumSystolic / totalCount).round(),
                averageDiastolic: (sumDiastolic / totalCount).round(),
                averageHeartRate: (sumHeartRate / totalCount).round(),
              ),
              const DottedDivider(margin: EdgeInsets.symmetric(vertical: 40)),
              BpRecordAnalysis(
                count: bpList?.length ?? 0,
                sumNormal: sumNormal,
                sumRisk: sumRisk,
                sumHighRisk: sumHighRisk,
              ),
              const DottedDivider(margin: EdgeInsets.symmetric(vertical: 40)),
              BpFigure(bpList: bpList),
              const DottedDivider(margin: EdgeInsets.symmetric(vertical: 40)),
              HeartRateFigure(bpList: bpList)
            ],
          ),
        ),
      ),
    );
  }
}
