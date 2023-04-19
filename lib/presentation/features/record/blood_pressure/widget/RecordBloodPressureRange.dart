import 'package:flutter/material.dart';
import 'package:odac_flutter_app/presentation/features/record/blood_pressure/widget/LevelDivider.dart';
import 'package:odac_flutter_app/presentation/features/record/model/RecordRangeStatus.dart';
import 'package:odac_flutter_app/presentation/features/record/model/RecordType.dart';
import 'package:odac_flutter_app/presentation/ui/colors.dart';
import 'package:odac_flutter_app/presentation/ui/typography.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';

import '../../widget/RangeResult.dart';

class RecordBloodPressureRange extends StatelessWidget {
  const RecordBloodPressureRange({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 35),
          _HeartBeatTitle(context),
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

  /** 맥박 제목 */
  Widget _HeartBeatTitle(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        getAppLocalizations(context).record_blood_pressure_range_title,
        style: getTextTheme(context).t2b.copyWith(
              color: getColorScheme(context).colorText,
            ),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
