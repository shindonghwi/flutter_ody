import 'package:flutter/material.dart';
import 'package:ody_flutter_app/presentation/features/analysis/widget/AnalysisItemTitle.dart';
import 'package:ody_flutter_app/presentation/ui/colors.dart';
import 'package:ody_flutter_app/presentation/ui/typography.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';
import 'package:ody_flutter_app/presentation/utils/dto/Triple.dart';

class AverageGlucose extends StatelessWidget {
  const AverageGlucose({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final averageItems = [
      Triple(
        getAppLocalizations(context).analysis_glucose_record_range_fasting,
        99,
        getAppLocalizations(context).record_glucose_input_unit,
      ),
      Triple(
        getAppLocalizations(context).analysis_glucose_record_range_preprandial,
        144,
        getAppLocalizations(context).record_glucose_input_unit,
      ),
      Triple(
        getAppLocalizations(context).analysis_glucose_record_range_postprandial,
        0,
        getAppLocalizations(context).record_glucose_input_unit,
      ),
      Triple(
        getAppLocalizations(context).analysis_glucose_record_range_postExercise,
        86,
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
            getAppLocalizations(context).analysis_glucose_record_range_text_unit(2),
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
