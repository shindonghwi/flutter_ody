import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ody_flutter_app/presentation/components/progress/PainterLinearHorizontalProgress.dart';
import 'package:ody_flutter_app/presentation/ui/colors.dart';
import 'package:ody_flutter_app/presentation/ui/typography.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';
import 'package:ody_flutter_app/presentation/utils/regex/RegexUtil.dart';

class ReportWalk extends HookWidget {
  final int totalSteps;

  const ReportWalk({
    Key? key,
    required this.totalSteps,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 43, 16, 0),
      child: Column(
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
                progress: 0.5,
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
              getAppLocalizations(context).report_walking_description(RegexUtil.commaNumber(280000)),
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
