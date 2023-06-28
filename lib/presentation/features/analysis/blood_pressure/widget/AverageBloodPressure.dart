import 'package:flutter/material.dart';
import 'package:ody_flutter_app/presentation/features/analysis/widget/AnalysisItemTitle.dart';
import 'package:ody_flutter_app/presentation/ui/colors.dart';
import 'package:ody_flutter_app/presentation/ui/typography.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';
import 'package:ody_flutter_app/presentation/utils/dto/Triple.dart';

class AverageBloodPressure extends StatelessWidget {
  final int count;

  const AverageBloodPressure({
    super.key,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    final averageItems = [
      Triple(
        getAppLocalizations(context).analysis_blood_pressure_average_systolic,
        110,
        getAppLocalizations(context).record_blood_pressure_input1_unit,
      ),
      Triple(
        getAppLocalizations(context).analysis_blood_pressure_average_diastolic,
        110,
        getAppLocalizations(context).record_blood_pressure_input1_unit,
      ),
      Triple(
        getAppLocalizations(context).analysis_blood_pressure_average_heart_rate,
        86,
        getAppLocalizations(context).record_blood_pressure_input2_unit,
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnalysisItemTitle(
          title: getAppLocalizations(context).analysis_blood_pressure_average,
          secondTitle: Triple(
            getAppLocalizations(context).analysis_blood_pressure_average_measure_text1,
            getAppLocalizations(context).analysis_blood_pressure_average_measure_text_unit(count),
            getAppLocalizations(context).analysis_blood_pressure_average_measure_text2,
          ),
          description: getAppLocalizations(context).analysis_blood_pressure_average_measure_description,
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
