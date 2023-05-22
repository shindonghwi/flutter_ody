import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:odac_flutter_app/presentation/features/record/model/RecordType.dart';
import 'package:odac_flutter_app/presentation/ui/colors.dart';
import 'package:odac_flutter_app/presentation/ui/typography.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';

import '../blood_pressure/widget/LevelDivider.dart';
import '../model/RecordRangeStatus.dart';

class RangeResult extends HookWidget {
  final RecordType type;
  final RecordRangeStatus status;
  final int level;

  const RangeResult({
    super.key,
    required RecordType this.type,
    required RecordRangeStatus this.status,
    required int this.level,
  });



  @override
  Widget build(BuildContext context) {
    final colorList = RecordRangeStatusHelper.getDividerColorList(context, status);

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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  getAppLocalizations(context)
                                      .record_range_figure_low_bp,
                                  style: getTextTheme(context).c2r.copyWith(
                                    color: getColorScheme(context).neutral70,
                                  ),
                                ),
                                const SizedBox(width: 19),
                                Text(
                                  getAppLocalizations(context)
                                      .record_range_figure_normal,
                                  style: getTextTheme(context).c2r.copyWith(
                                    color: getColorScheme(context).neutral70,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              getAppLocalizations(context)
                                  .record_range_figure_high_bp,
                              style: getTextTheme(context).c2r.copyWith(
                                color: getColorScheme(context).neutral70,
                              ),
                            ),
                          ],
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
}
