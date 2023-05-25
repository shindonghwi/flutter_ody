import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:odac_flutter_app/presentation/components/appbar/IconTitleTextAppBar.dart';
import 'package:odac_flutter_app/presentation/components/appbar/model/AppBarIcon.dart';
import 'package:odac_flutter_app/presentation/features/record/blood_pressure/models/BpRecorderModel.dart';
import 'package:odac_flutter_app/presentation/features/record/blood_pressure/notifier/BloodPressureRecorderNotifier.dart';
import 'package:odac_flutter_app/presentation/features/record/blood_pressure/notifier/RecordBloodPressureUiStateNotifier.dart';
import 'package:odac_flutter_app/presentation/features/record/model/RecordRangeStatus.dart';
import 'package:odac_flutter_app/presentation/ui/colors.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';

class RecordBloodPressureAppBar extends HookConsumerWidget with PreferredSizeWidget {
  const RecordBloodPressureAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bgRecorder = ref.watch<BpRecorderModel>(bloodPressureRecorderProvider);
    final bgRecorderRead = ref.read(bloodPressureRecorderProvider.notifier);
    final bpStateRead = ref.read(recordBloodPressureUiStateProvider.notifier);

    final actionTextColor =  bgRecorderRead.checkBpLevel() != 0
        ? getColorScheme(context).colorText
        : getColorScheme(context).neutral50;

    final actionIconEnable = bgRecorderRead.checkBpStatus() != RecordRangeStatus.None;

    return IconTitleTextAppBar(
      leadingIcon: AppBarIcon(
        path: 'assets/imgs/icon_back.svg',
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: getAppLocalizations(context).record_blood_pressure,
      actionText: getAppLocalizations(context).common_save,
      actionTextColor: actionTextColor,
      actionIconEnable: actionIconEnable,
      actionTextCallback: () {
        bpStateRead.postBp(
          time: bgRecorder.time,
          systolicBloodPressure: bgRecorder.systolic,
          diastolicBloodPressure: bgRecorder.diastolic,
          heartRate: bgRecorder.hr,
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, 56);
}
