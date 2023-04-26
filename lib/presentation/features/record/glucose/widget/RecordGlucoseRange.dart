import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';
import 'package:odac_flutter_app/presentation/features/record/model/RecordRangeStatus.dart';
import 'package:odac_flutter_app/presentation/features/record/model/RecordType.dart';
import 'package:odac_flutter_app/presentation/features/record/widget/RangeResult.dart';
import 'package:odac_flutter_app/presentation/ui/colors.dart';
import 'package:odac_flutter_app/presentation/ui/typography.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';

class RecordGlucoseRange extends HookWidget {
  const RecordGlucoseRange({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(height: 35),
          _GlucoseTitle(context),
          SizedBox(height: 12),
          RangeResult(
            type: RecordType.BloodPressure,
            status: RecordRangeStatus.Normal,
            level: 3,
          ),
        ],
      ),
    );
  }

  /** 혈당 제목 */
  Widget _GlucoseTitle(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        getAppLocalizations(context).record_glucose_range_title,
        style: getTextTheme(context).t2b.copyWith(
          color: getColorScheme(context).colorText,
        ),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
