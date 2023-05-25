import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:odac_flutter_app/presentation/features/record/glucose/models/GlucoseRecorderModel.dart';
import 'package:odac_flutter_app/presentation/features/record/glucose/notifier/GlucoseRecorderNotifier.dart';
import 'package:odac_flutter_app/presentation/features/record/model/RecordRangeStatus.dart';
import 'package:odac_flutter_app/presentation/features/record/model/RecordType.dart';
import 'package:odac_flutter_app/presentation/features/record/widget/RangeResult.dart';
import 'package:odac_flutter_app/presentation/ui/colors.dart';
import 'package:odac_flutter_app/presentation/ui/typography.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';

class RecordGlucoseRange extends HookConsumerWidget {
  const RecordGlucoseRange({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final glucoseRecorder = ref.watch<GlucoseRecorderModel>(glucoseRecorderProvider);
    final glucoseRecorderRead = ref.read(glucoseRecorderProvider.notifier);

    return Column(
      children: [
        const SizedBox(height: 32),
        _glucoseTitle(context),
        const SizedBox(height: 15),
        RangeResult(
          type: RecordType.Glucose,
          status: glucoseRecorderRead.checkGlucoseStatus(),
          level: glucoseRecorderRead.checkGlucoseLevel(),
        ),
      ],
    );
  }

  /// 혈당 제목
  Widget _glucoseTitle(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        getAppLocalizations(context).record_glucose_range_title,
        style: getTextTheme(context).t2b.copyWith(
          color: getColorScheme(context).colorText,
        ),
      ),
    );
  }
}
