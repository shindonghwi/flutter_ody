import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ody_flutter_app/data/models/bio/ResponseBioReportInfoModel.dart';
import 'package:ody_flutter_app/presentation/components/appbar/IconTitleIconAppBar.dart';
import 'package:ody_flutter_app/presentation/components/appbar/model/AppBarIcon.dart';
import 'package:ody_flutter_app/presentation/components/loading/CircleLoading.dart';
import 'package:ody_flutter_app/presentation/features/report/monthly/provider/ReportMonthlyProvider.dart';
import 'package:ody_flutter_app/presentation/features/report/weekly/ReportWeeklyScreen.dart';
import 'package:ody_flutter_app/presentation/models/UiState.dart';
import 'package:ody_flutter_app/presentation/ui/colors.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';
import 'package:ody_flutter_app/presentation/utils/snackbar/SnackBarUtil.dart';

class ReportMonthlyScreen extends HookConsumerWidget {
  final int? reportSeq;

  const ReportMonthlyScreen({
    Key? key,
    this.reportSeq,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uiState = ref.watch(reportMonthlyProvider);
    final uiStateRead = ref.read(reportMonthlyProvider.notifier);

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
        uiStateRead.requestMonthlyInfo(reportSeq);
      });
    }, []);

    return Scaffold(
      appBar: IconTitleIconAppBar(
        leadingIcon: AppBarIcon(
          path: 'assets/imgs/icon_back.svg',
          onPressed: () => Navigator.of(context).pop(),
          tint: getColorScheme(context).colorText,
        ),
        title: getAppLocalizations(context).my_item_subtitle_monthly_report,
      ),
      backgroundColor: getColorScheme(context).colorUI03,
      body: uiState is Success<ResponseBioReportInfoModel>
          ? SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(15, 24, 15, 64),
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            ReportCardWalk(isWeekly: false, walking: uiState.value.walking),
            const SizedBox(height: 24),
            ReportCardBloodPressure(isWeekly: false, bloodPressure: uiState.value.bloodPressure),
            // const SizedBox(height: 24),
            // ReportCardGlucose(glucose: uiState.value.glucose),
          ],
        ),
      )
          : uiState is Loading
          ? const CircleLoading()
          : const SizedBox(),
    );
  }
}
