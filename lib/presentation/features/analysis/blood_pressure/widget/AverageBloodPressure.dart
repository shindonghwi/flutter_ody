import 'package:flutter/material.dart';
import 'package:ody_flutter_app/presentation/features/analysis/widget/AnalysisItemTitle.dart';
import 'package:ody_flutter_app/presentation/ui/colors.dart';
import 'package:ody_flutter_app/presentation/ui/typography.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';
import 'package:ody_flutter_app/presentation/utils/dto/Triple.dart';

class AverageBloodPressure extends StatelessWidget {
  final String title;
  final Triple secondTitle;
  final String description;
  final int averageSystolic;
  final int averageDiastolic;
  final int averageHeartRate;

  const AverageBloodPressure({
    super.key,
    required this.title,
    required this.secondTitle,
    required this.description,
    required this.averageSystolic,
    required this.averageDiastolic,
    required this.averageHeartRate,
  });

  @override
  Widget build(BuildContext context) {
    final averageItems = [
      Triple(
        getAppLocalizations(context).analysis_blood_pressure_average_systolic,
        averageSystolic,
        getAppLocalizations(context).record_blood_pressure_input1_unit,
      ),
      Triple(
        getAppLocalizations(context).analysis_blood_pressure_average_diastolic,
        averageDiastolic,
        getAppLocalizations(context).record_blood_pressure_input1_unit,
      ),
      Triple(
        getAppLocalizations(context).analysis_blood_pressure_average_heart_rate,
        averageHeartRate,
        getAppLocalizations(context).record_blood_pressure_input2_unit,
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnalysisItemTitle(
          title: title,
          secondTitle: secondTitle,
          description: description,
        ),
        const SizedBox(
          height: 40,
        ),
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
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
