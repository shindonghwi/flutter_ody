import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ody_flutter_app/presentation/features/report/monthly/provider/ReportMonthlyProvider.dart';
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
        uiStateRead.requestMonyhlyInfo();
      });
    }, []);

    return Center(
      child: Text("ReportMonthlyScreen : reportSeq: $reportSeq"),
    );
  }
}
