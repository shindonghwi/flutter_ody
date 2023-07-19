import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ody_flutter_app/presentation/components/appbar/IconTitleTextAppBar.dart';
import 'package:ody_flutter_app/presentation/components/appbar/model/AppBarIcon.dart';
import 'package:ody_flutter_app/presentation/features/record/glucose/models/GlucoseRecorderModel.dart';
import 'package:ody_flutter_app/presentation/features/record/glucose/notifier/GlucoseRecorderNotifier.dart';
import 'package:ody_flutter_app/presentation/features/record/glucose/notifier/RecordGlucoseUiStateNotifier.dart';
import 'package:ody_flutter_app/presentation/features/record/model/RecordRangeStatus.dart';
import 'package:ody_flutter_app/presentation/ui/colors.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';

class RecordGlucoseAppBar extends HookConsumerWidget implements PreferredSizeWidget {
  const RecordGlucoseAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final glucoseRecorder = ref.watch<GlucoseRecorderModel>(glucoseRecorderProvider);
    final glucoseRecorderRead = ref.read(glucoseRecorderProvider.notifier);
    final glucoseStateRead = ref.read(recordGlucoseUiStateProvider.notifier);

    final actionTextColor =
        glucoseRecorderRead.checkGlucoseStatus() != RecordRangeStatus.None
            ? getColorScheme(context).colorText
            : getColorScheme(context).neutral50;

    final actionIconEnable =
        glucoseRecorderRead.checkGlucoseStatus() != RecordRangeStatus.None;

    return IconTitleTextAppBar(
      leadingIcon: AppBarIcon(
        path: 'assets/imgs/icon_back.svg',
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: getAppLocalizations(context).record_glucose_input_title,
      actionText: getAppLocalizations(context).common_save,
      actionTextColor: actionTextColor,
      actionIconEnable: actionIconEnable,
      actionTextCallback: () {
        glucoseStateRead.postGlucose(
          time: glucoseRecorder.time,
          type: glucoseRecorder.measureType,
          glucose: glucoseRecorder.glucose,
          memo: glucoseRecorder.memo,
          remindTime: glucoseRecorder.remindTime,
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, 56);
}
