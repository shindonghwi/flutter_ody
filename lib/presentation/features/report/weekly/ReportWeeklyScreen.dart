import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ody_flutter_app/data/models/bio/ResponseBioReportBloodPressureModel.dart';
import 'package:ody_flutter_app/data/models/bio/ResponseBioReportGlucoseModel.dart';
import 'package:ody_flutter_app/data/models/bio/ResponseBioReportWalkingModel.dart';
import 'package:ody_flutter_app/data/models/bio/ResponseBioReportInfoModel.dart';
import 'package:ody_flutter_app/presentation/components/appbar/IconTitleIconAppBar.dart';
import 'package:ody_flutter_app/presentation/components/appbar/model/AppBarIcon.dart';
import 'package:ody_flutter_app/presentation/components/divider/DottedDivider.dart';
import 'package:ody_flutter_app/presentation/components/loading/CircleLoading.dart';
import 'package:ody_flutter_app/presentation/features/report/weekly/provider/ReportWeeklyProvider.dart';
import 'package:ody_flutter_app/presentation/features/report/widget/ReportBloodPressure.dart';
import 'package:ody_flutter_app/presentation/features/report/widget/ReportBloodPressureAnalysis.dart';
import 'package:ody_flutter_app/presentation/features/report/widget/ReportBloodPressureGraph.dart';
import 'package:ody_flutter_app/presentation/features/report/widget/ReportCalorie.dart';
import 'package:ody_flutter_app/presentation/features/report/widget/ReportGlucose.dart';
import 'package:ody_flutter_app/presentation/features/report/widget/ReportGlucoseAnalysis.dart';
import 'package:ody_flutter_app/presentation/features/report/widget/ReportGlucoseGraph.dart';
import 'package:ody_flutter_app/presentation/features/report/widget/ReportHeartRateGraph.dart';
import 'package:ody_flutter_app/presentation/features/report/widget/ReportWalk.dart';
import 'package:ody_flutter_app/presentation/features/report/widget/ReportWalkCompare.dart';
import 'package:ody_flutter_app/presentation/features/report/widget/ReportWalkingAverage.dart';
import 'package:ody_flutter_app/presentation/models/UiState.dart';
import 'package:ody_flutter_app/presentation/ui/colors.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';
import 'package:ody_flutter_app/presentation/utils/snackbar/SnackBarUtil.dart';

class ReportWeeklyScreen extends HookConsumerWidget {
  final int? reportSeq;

  const ReportWeeklyScreen({
    Key? key,
    this.reportSeq,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uiState = ref.watch(reportWeeklyProvider);
    final uiStateRead = ref.read(reportWeeklyProvider.notifier);

    useEffect(() {
      void handleUiStateChange() async {
        await Future(() {
          uiState.when(
            failure: (event) => SnackBarUtil.show(context, event.errorMessage),
          );
        });
      }

      handleUiStateChange();
      return null;
    }, [uiState]);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        uiStateRead.init();
        uiStateRead.requestWeeklyInfo(reportSeq);
      });
    }, []);

    return Scaffold(
      appBar: IconTitleIconAppBar(
        leadingIcon: AppBarIcon(
          path: 'assets/imgs/icon_back.svg',
          onPressed: () => Navigator.of(context).pop(),
          tint: getColorScheme(context).colorText,
        ),
        title: getAppLocalizations(context).my_item_subtitle_weekly_report,
      ),
      backgroundColor: getColorScheme(context).colorUI03,
      body: uiState is Success<ResponseBioReportInfoModel>
          ? SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(15, 24, 15, 64),
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  ReportCardWalk(isWeekly: true, walking: uiState.value.walking),
                  const SizedBox(height: 24),
                  ReportCardBloodPressure(bloodPressure: uiState.value.bloodPressure),
                  const SizedBox(height: 24),
                  ReportCardGlucose(glucose: uiState.value.glucose),
                ],
              ),
            )
          : uiState is Loading
              ? const CircleLoading()
              : const SizedBox(),
    );
  }
}

class ReportCardWalk extends StatelessWidget {
  final bool isWeekly;
  final ResponseBioReportWalkingModel walking;

  const ReportCardWalk({
    Key? key,
    required this.isWeekly,
    required this.walking,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: getColorScheme(context).colorUI02,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          ReportWalk(totalSteps: walking.totalSteps),
          const DottedDivider(margin: EdgeInsets.symmetric(vertical: 40, horizontal: 12)),
          ReportCalorie(totalCalories: walking.totalCalories),
          const DottedDivider(margin: EdgeInsets.symmetric(vertical: 40, horizontal: 12)),
          ReportWalkingAverage(averageSteps: walking.averageSteps, days: walking.days),
          const DottedDivider(margin: EdgeInsets.symmetric(vertical: 40, horizontal: 12)),
          ReportWalkCompare(beforeSteps: walking.beforeSteps, totalSteps: walking.totalSteps),
          const SizedBox(height: 36)
        ],
      ),
    );
  }
}

class ReportCardBloodPressure extends StatelessWidget {
  final ResponseBioReportBloodPressureModel bloodPressure;

  const ReportCardBloodPressure({
    Key? key,
    required this.bloodPressure,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: getColorScheme(context).colorUI02,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          ReportBloodPressure(
            totalCount: bloodPressure.totalCount,
            averageSystolic: bloodPressure.averageSystolic,
            averageDiastolic: bloodPressure.averageDiastolic,
            averageHeartRate: bloodPressure.averageHeartRate,
          ),
          const DottedDivider(margin: EdgeInsets.symmetric(vertical: 40, horizontal: 12)),
          ReportBloodPressureAnalysis(totalCount: bloodPressure.totalCount, states: bloodPressure.states),
          const DottedDivider(margin: EdgeInsets.symmetric(vertical: 40, horizontal: 12)),
          ReportBloodPressureGraph(days: bloodPressure.days),
          const DottedDivider(margin: EdgeInsets.symmetric(vertical: 40, horizontal: 12)),
          ReportHeartRateGraph(days: bloodPressure.days),
          const SizedBox(height: 40)
        ],
      ),
    );
  }
}

class ReportCardGlucose extends StatelessWidget {
  final ResponseBioReportGlucoseModel glucose;

  const ReportCardGlucose({
    Key? key,
    required this.glucose,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: getColorScheme(context).colorUI02,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          ReportGlucose(
            totalCount: glucose.totalCount,
            averageFasting: ((glucose.minFastingGlucose + glucose.maxFastingGlucose) / 2).round(),
            averagePreprandial: ((glucose.minPreprandialGlucose + glucose.maxPreprandialGlucose) / 2).round(),
            averagePostprandial: ((glucose.minPostprandialGlucose + glucose.maxPostprandialGlucose) / 2).round(),
            averagePostExercise: ((glucose.minPostExerciseGlucose + glucose.maxPostExerciseGlucose) / 2).round(),
          ),
          const DottedDivider(margin: EdgeInsets.symmetric(vertical: 40, horizontal: 12)),
          ReportGlucoseAnalysis(totalCount: glucose.totalCount, states: glucose.states),
          const DottedDivider(margin: EdgeInsets.symmetric(vertical: 40, horizontal: 12)),
          ReportGlucoseGraph(
            minFastingGlucose: glucose.minFastingGlucose,
            maxFastingGlucose: glucose.maxFastingGlucose,
            days: glucose.days,
          ),
          const SizedBox(height: 40)
        ],
      ),
    );
  }
}
