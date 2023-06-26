import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ody_flutter_app/data/models/bio/ResponseBioStatusModel.dart';
import 'package:ody_flutter_app/presentation/features/record/blood_pressure/notifier/RecordBloodPressureUiStateNotifier.dart';
import 'package:ody_flutter_app/presentation/features/record/glucose/notifier/RecordGlucoseUiStateNotifier.dart';
import 'package:ody_flutter_app/presentation/features/record/model/RecordType.dart';
import 'package:ody_flutter_app/presentation/ui/colors.dart';
import 'package:ody_flutter_app/presentation/ui/typography.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';

import '../model/RecordRangeStatus.dart';
import 'LevelDivider.dart';

class RangeResult extends HookConsumerWidget {
  final RecordType type;
  final RecordRangeStatus status;
  final int level;

  const RangeResult({
    super.key,
    required this.type,
    required this.status,
    required this.level,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorList = RecordRangeStatusHelper.getDividerColorList(context, type, status);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 10),
      height: 84,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            fit: FlexFit.tight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "\"${RecordRangeStatusHelper.fromString(status)}\"",
                        style: getTextTheme(context).b2b.copyWith(
                              color: RecordRangeStatusHelper.getStatusColor(context, status),
                            ),
                      ),
                      TextSpan(
                        text: getAppLocalizations(context).record_range_figure,
                        style: getTextTheme(context).b3sb.copyWith(
                              color: RecordRangeStatusHelper.getSubTextColor(context, status),
                            ),
                      ),
                    ],
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  width: 200,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                        child: LevelDivider(
                          length: colorList.length,
                          level: level,
                          colors: colorList,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: SizedBox(
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: type == RecordType.BloodPressure
                                ? getBpRangeText(context)
                                : getGlucoseRangeText(context),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Image.asset(
            RecordRangeStatusHelper.getOdyImagePath(type, status),
          )
        ],
      ),
    );
  }

  List<Widget> getBpRangeText(BuildContext context) {
    return [
      Row(
        children: [
          Text(
            getAppLocalizations(context).record_range_figure_low_bp,
            style: getTextTheme(context).c2r.copyWith(
                  color: getColorScheme(context).neutral70,
                ),
          ),
          const SizedBox(width: 19),
          Text(
            getAppLocalizations(context).record_range_figure_normal,
            style: getTextTheme(context).c2r.copyWith(
                  color: getColorScheme(context).neutral70,
                ),
          ),
        ],
      ),
      Text(
        getAppLocalizations(context).record_range_figure_high_bp,
        style: getTextTheme(context).c2r.copyWith(
              color: getColorScheme(context).neutral70,
            ),
      ),
    ];
  }

  List<Widget> getGlucoseRangeText(BuildContext context) {
    return [
      Flexible(
          fit: FlexFit.tight,
          flex: 1,
          child: Text(
            getAppLocalizations(context).record_range_figure_normal,
            style: getTextTheme(context).c2r.copyWith(
                  color: getColorScheme(context).neutral70,
                ),
            textAlign: TextAlign.right,
          )),
      Flexible(
          fit: FlexFit.tight,
          flex: 1,
          child: Text(
            getAppLocalizations(context).record_range_figure_warning,
            style: getTextTheme(context).c2r.copyWith(
                  color: getColorScheme(context).neutral70,
                ),
            textAlign: TextAlign.right,
          )),
      Flexible(
          fit: FlexFit.tight,
          flex: 1,
          child: Text(
            getAppLocalizations(context).record_range_figure_danger,
            style: getTextTheme(context).c2r.copyWith(
                  color: getColorScheme(context).neutral70,
                ),
            textAlign: TextAlign.right,
          )),
    ];
  }
}
