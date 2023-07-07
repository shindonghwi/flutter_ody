import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ody_flutter_app/presentation/components/progress/PainterLinearHorizontalProgress.dart';
import 'package:ody_flutter_app/presentation/ui/colors.dart';
import 'package:ody_flutter_app/presentation/ui/typography.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';
import 'package:ody_flutter_app/presentation/utils/date/DateParser.dart';
import 'package:ody_flutter_app/presentation/utils/regex/RegexUtil.dart';

class ReportWalk extends HookWidget {
  final bool isWeekly;
  final int totalSteps;

  const ReportWalk({
    Key? key,
    required this.isWeekly,
    required this.totalSteps,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 43, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/imgs/icon_shoes.png',
                width: 24,
                height: 24,
              ),
              const SizedBox(width: 8),
              Text(
                getAppLocalizations(context).report_walking_title,
                style: getTextTheme(context).t1b.copyWith(
                      color: getColorScheme(context).colorText,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          Text(
            isWeekly
                ? getAppLocalizations(context).report_walking_weekly_subtitle
                : getAppLocalizations(context).report_walking_monthly_subtitle,
            style: getTextTheme(context).b3sb.copyWith(
                  color: getColorScheme(context).colorPrimaryFocus,
                ),
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                RegexUtil.commaNumber(totalSteps),
                style: getTextTheme(context).t2b.copyWith(
                      color: getColorScheme(context).colorText,
                    ),
              ),
              const SizedBox(width: 8),
              Text(
                getAppLocalizations(context).common_walk,
                style: getTextTheme(context).b2b.copyWith(
                      color: getColorScheme(context).neutral70,
                    ),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          SizedBox(
            width: double.infinity,
            height: 10,
            child: CustomPaint(
              painter: PainterLinearHorizontalProgress(
                progress: totalSteps / (isWeekly ? 70000 : DateParser.getLastDayFromCurrentMonth() * 10000),
                defaultColor: getColorScheme(context).colorPrimaryDisable,
                activeColor: getColorScheme(context).primary100,
                radius: 100,
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              getAppLocalizations(context).report_walking_description(
                RegexUtil.commaNumber(isWeekly ? 70000 : DateParser.getLastDayFromCurrentMonth() * 10000),
              ),
              style: getTextTheme(context).c3m.copyWith(
                    color: getColorScheme(context).neutral60,
                  ),
            ),
          )
        ],
      ),
    );
  }
}
