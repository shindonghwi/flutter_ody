import 'package:flutter/material.dart';
import 'package:ody_flutter_app/presentation/features/analysis/widget/AnalysisItemTitle.dart';
import 'package:ody_flutter_app/presentation/ui/colors.dart';
import 'package:ody_flutter_app/presentation/ui/typography.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';
import 'package:ody_flutter_app/presentation/utils/dto/Triple.dart';

class AverageGlucose extends StatelessWidget {
  final int count;
  final int averageFasting;
  final int averagePreprandial;
  final int averagePostprandial;
  final int averagePostExercise;

  const AverageGlucose({
    super.key,
    required this.count,
    required this.averageFasting,
    required this.averagePreprandial,
    required this.averagePostprandial,
    required this.averagePostExercise,
  });

  @override
  Widget build(BuildContext context) {
    final averageItems = [
      Triple(
        getAppLocalizations(context).analysis_glucose_record_range_fasting,
        averageFasting,
        getAppLocalizations(context).record_glucose_input_unit,
      ),
      Triple(
        getAppLocalizations(context).analysis_glucose_record_range_preprandial,
        averagePreprandial,
        getAppLocalizations(context).record_glucose_input_unit,
      ),
      Triple(
        getAppLocalizations(context).analysis_glucose_record_range_postprandial,
        averagePostprandial,
        getAppLocalizations(context).record_glucose_input_unit,
      ),
      Triple(
        getAppLocalizations(context).analysis_glucose_record_range_postExercise,
        averagePostExercise,
        getAppLocalizations(context).record_glucose_input_unit,
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnalysisItemTitle(
          title: getAppLocalizations(context).analysis_glucose_record_range,
          secondTitle: Triple(
            getAppLocalizations(context).analysis_glucose_record_range_text1,
            getAppLocalizations(context).analysis_glucose_record_range_text_unit(count),
            getAppLocalizations(context).analysis_glucose_record_range_text2,
          ),
          description: getAppLocalizations(context).analysis_glucose_record_range_description,
        ),
        const SizedBox(
          height: 40,
        ),
        ListView.separated(
          padding: const EdgeInsets.all(0),
          shrinkWrap: true,
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(height: 16); // Adjust the height as needed
          },
          itemBuilder: (BuildContext context, int index) {
            final item = averageItems[index];
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  item.first,
                  style: getTextTheme(context).b3sb.copyWith(
                        color: getColorScheme(context).colorText,
                      ),
                ),
                Row(
                  children: [
                    Text(
                      item.second.toString(),
                      style: getTextTheme(context).t2b.copyWith(
                            color: getColorScheme(context).colorPrimaryFocus,
                          ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      item.third,
                      style: getTextTheme(context).b2sb.copyWith(
                            color: getColorScheme(context).neutral70,
                          ),
                    ),
                  ],
                )
              ],
            );
          },
          itemCount: averageItems.length,
        ),
      ],
    );
  }
}
