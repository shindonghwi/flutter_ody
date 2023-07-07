import 'package:flutter/material.dart';
import 'package:ody_flutter_app/presentation/ui/colors.dart';
import 'package:ody_flutter_app/presentation/ui/typography.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';
import 'package:ody_flutter_app/presentation/utils/dto/Triple.dart';

class AnalysisItemTitle extends StatelessWidget {
  final String title;
  final Triple secondTitle;
  final String description;

  const AnalysisItemTitle({
    Key? key,
    required this.title,
    required this.secondTitle,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: getTextTheme(context).b3sb.copyWith(
            color: getColorScheme(context).colorPrimaryFocus,
          ),
        ),
        const SizedBox(
          height: 8,
        ),

        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              secondTitle.first,
              style: getTextTheme(context).t2b.copyWith(
                color: getColorScheme(context).colorText,
                  height: 1.2
              ),
              overflow: TextOverflow.visible,
            ),
            Text(
              " ${secondTitle.second} ",
              style: getTextTheme(context).t2b.copyWith(
                color: getColorScheme(context).colorPrimaryFocus,
                height: 1.2
              ),
              overflow: TextOverflow.visible,
            ),
            Text(
              secondTitle.third,
              style: getTextTheme(context).t2b.copyWith(
                color: getColorScheme(context).colorText,
                  height: 1.2
              ),
              overflow: TextOverflow.visible,
            ),
          ],
        ),

        const SizedBox(
          height: 8,
        ),
        Text(
          description,
          style: getTextTheme(context).c2r.copyWith(
            color: getColorScheme(context).neutral60,
            height: 1.16,
          ),
          overflow: TextOverflow.visible,
        ),
      ],
    );
  }
}
