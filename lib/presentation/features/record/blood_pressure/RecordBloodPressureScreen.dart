import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:odac_flutter_app/presentation/components/loading/CircleLoading.dart';
import 'package:odac_flutter_app/presentation/features/record/blood_pressure/notifier/BloodPressureRecorderNotifier.dart';
import 'package:odac_flutter_app/presentation/features/record/blood_pressure/notifier/RecordBloodPressureUiStateNotifier.dart';
import 'package:odac_flutter_app/presentation/features/record/blood_pressure/widget/RecordBloodPressure.dart';
import 'package:odac_flutter_app/presentation/features/record/blood_pressure/widget/RecordBloodPressureAppBar.dart';
import 'package:odac_flutter_app/presentation/features/record/widget/RecordDateSelector.dart';
import 'package:odac_flutter_app/presentation/models/UiState.dart';
import 'package:odac_flutter_app/presentation/ui/colors.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';
import 'package:odac_flutter_app/presentation/utils/snackbar/SnackBarUtil.dart';

class RecordBloodPressureScreen extends HookConsumerWidget {
  const RecordBloodPressureScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch<UIState<String?>>(recordBloodPressureUiStateProvider);
    final stateProvider = ref.read(recordBloodPressureUiStateProvider.notifier);
    final bpRecorderProvider = ref.read(bloodPressureRecorderProvider.notifier);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        state.when(
          success: (event) async {
            SnackBarUtil.show(context,
                getAppLocalizations(context).message_record_complete_blood_pressure);
            stateProvider.resetState();
            Navigator.pop(context);
          },
          failure: (event) {
            SnackBarUtil.show(context, event.errorMessage);
          },
          idle: (_) {
            final List<String> yearMonthDay =
                DateTime.now().toString().split(" ")[0].split("-");
            final List<String> hourMinuteSecond =
                DateTime.now().toString().split(" ")[1].split(":");

            bpRecorderProvider.updateTime(DateTime(
              double.parse(yearMonthDay[0]).toInt(),
              double.parse(yearMonthDay[1]).toInt(),
              double.parse(yearMonthDay[2]).toInt(),
              double.parse(hourMinuteSecond[0]).toInt(),
              double.parse(hourMinuteSecond[1]).toInt(),
              double.parse(hourMinuteSecond[2]).toInt(),
            ));
          },
        );
      });
    }, [state]);

    return Stack(
      children: [
        Scaffold(
          backgroundColor: getColorScheme(context).colorUI03,
          appBar: const RecordBloodPressureAppBar(),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: const [
                RecordDateSelector(),
                RecordBloodPressure(),
              ],
            ),
          ),
        ),
        if (state is Loading) const CircleLoading(),
      ],
    );
  }
}
