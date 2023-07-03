import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ody_flutter_app/presentation/components/appbar/IconTitleIconAppBar.dart';
import 'package:ody_flutter_app/presentation/components/appbar/model/AppBarIcon.dart';
import 'package:ody_flutter_app/presentation/components/divider/DottedDivider.dart';
import 'package:ody_flutter_app/presentation/features/analysis/widget/AnalysisItemTitle.dart';
import 'package:ody_flutter_app/presentation/features/report/weekly/provider/ReportWeeklyProvider.dart';
import 'package:ody_flutter_app/presentation/features/report/widget/ReportCalorie.dart';
import 'package:ody_flutter_app/presentation/features/report/widget/ReportWalk.dart';
import 'package:ody_flutter_app/presentation/features/report/widget/ReportWalkingAverage.dart';
import 'package:ody_flutter_app/presentation/ui/colors.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';
import 'package:ody_flutter_app/presentation/utils/dto/Triple.dart';
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
        uiStateRead.requestWeeklyInfo();
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(15, 24, 15, 64),
        physics: const BouncingScrollPhysics(),
        child: Container(
          decoration: BoxDecoration(
            color: getColorScheme(context).colorUI02,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            children: const [
              ReportWalk(),
              DottedDivider(margin: EdgeInsets.symmetric(vertical: 40, horizontal: 12)),
              ReportCalorie(),
              DottedDivider(margin: EdgeInsets.symmetric(vertical: 40, horizontal: 12)),
              ReportWalkingAverage(),
              DottedDivider(margin: EdgeInsets.symmetric(vertical: 40, horizontal: 12)),
            ],
          ),
        ),
      ),
    );
  }
}
