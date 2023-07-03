import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ody_flutter_app/presentation/features/report/weekly/provider/ReportWeeklyProvider.dart';
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


    return Center(
      child: Text("ReportWeeklyScreen : reportSeq: $reportSeq"),
    );
  }
}
