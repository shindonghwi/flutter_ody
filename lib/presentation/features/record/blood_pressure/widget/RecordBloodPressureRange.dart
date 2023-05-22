import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:odac_flutter_app/presentation/features/record/blood_pressure/models/BpRecorderModel.dart';
import 'package:odac_flutter_app/presentation/features/record/blood_pressure/notifier/BloodPressureRecorderNotifier.dart';
import 'package:odac_flutter_app/presentation/features/record/blood_pressure/widget/LevelDivider.dart';
import 'package:odac_flutter_app/presentation/features/record/model/RecordRangeStatus.dart';
import 'package:odac_flutter_app/presentation/features/record/model/RecordType.dart';
import 'package:odac_flutter_app/presentation/ui/colors.dart';
import 'package:odac_flutter_app/presentation/ui/typography.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';
import 'package:odac_flutter_app/presentation/utils/dto/Triple.dart';

import '../../widget/RangeResult.dart';

class RecordBloodPressureRange extends HookConsumerWidget {
  const RecordBloodPressureRange({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final bpRecorder = ref.watch<BpRecorderModel>(bloodPressureRecorderProvider);
    final bpRecorderRead = ref.read(bloodPressureRecorderProvider.notifier);

    return Column(
      children: [
        const SizedBox(height: 32),
        _heartBeatTitle(context),
        const SizedBox(height: 15),
        RangeResult(
          type: RecordType.BloodPressure,
          status: bpRecorderRead.checkBpStatus(),
          level: bpRecorderRead.checkBpLevel(),
        ),
      ],
    );
  }

  /// 맥박 제목
  Widget _heartBeatTitle(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        getAppLocalizations(context).record_blood_pressure_range_title,
        style: getTextTheme(context).t2b.copyWith(
              color: getColorScheme(context).colorText,
            ),
      ),
    );
  }
}
