import 'package:flutter/material.dart';
import 'package:ody_flutter_app/presentation/components/progress/PainterLinearHorizontalProgress.dart';
import 'package:ody_flutter_app/presentation/features/analysis/widget/AnalysisItemTitle.dart';
import 'package:ody_flutter_app/presentation/ui/colors.dart';
import 'package:ody_flutter_app/presentation/ui/typography.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';
import 'package:ody_flutter_app/presentation/utils/dto/Triple.dart';

class ReportWalkCompare extends StatelessWidget {
  const ReportWalkCompare({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: Column(
        children: [
          AnalysisItemTitle(
            title: getAppLocalizations(context).report_weekly_pre_subtitle,
            secondTitle: Triple(
              getAppLocalizations(context).report_weekly_pre_text1,
              "6,108kcal",
              getAppLocalizations(context).report_monthly_pre_walk_more,
            ),
            description: getAppLocalizations(context).report_pre_description,
          ),
          const SizedBox(height: 32),
          _CompareItem(
            label: getAppLocalizations(context).common_week_pre,
            progressColor: getColorScheme(context).primary100,
          ),
          const SizedBox(height: 24),
          _CompareItem(
            label: getAppLocalizations(context).common_week_post,
            progressColor: getColorScheme(context).primary100.withOpacity(0.1),
          )
        ],
      ),
    );
  }
}

class _CompareItem extends StatelessWidget {
  final String label;
  final Color progressColor;

  const _CompareItem({
    super.key,
    required this.label,
    required this.progressColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 16,
      child: Row(
        children: [
          Flexible(
            flex: 74,
            fit: FlexFit.tight,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  label,
                  style: getTextTheme(context).c3m.copyWith(
                        color: getColorScheme(context).neutral70,
                      ),
                ),
                const SizedBox(
                  width: 25,
                ),
                Expanded(
                  child: SizedBox(
                    width: double.infinity,
                    height: 16,
                    child: CustomPaint(
                      painter: PainterLinearHorizontalProgress(
                        progress: 0.5,
                        defaultColor: getColorScheme(context).colorUI02,
                        activeColor: progressColor,
                        radius: 100,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Flexible(
            flex: 26,
            fit: FlexFit.tight,
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                "3324 ${getAppLocalizations(context).common_walk}",
                style: getTextTheme(context).c3m.copyWith(
                      color: getColorScheme(context).neutral70,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
