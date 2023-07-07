import 'package:flutter/material.dart';
import 'package:ody_flutter_app/presentation/ui/colors.dart';
import 'package:ody_flutter_app/presentation/ui/typography.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';

class BottomSheetGlucoseTable extends StatelessWidget {
  const BottomSheetGlucoseTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 7),
          width: 35,
          height: 3,
          decoration: BoxDecoration(
            color: getColorScheme(context).neutral40,
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        const SizedBox(
          height: 32,
        ),
        Text(
          getAppLocalizations(context).bottom_sheet_glucose_table_title,
          style: getTextTheme(context).t2b.copyWith(
                color: getColorScheme(context).colorText,
              ),
        ),
        const SizedBox(
          height: 32,
        ),
        Text(
          getAppLocalizations(context).bottom_sheet_glucose_table_description,
          style: getTextTheme(context).c2r.copyWith(
                color: getColorScheme(context).neutral80,
              ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 24, right: 24, top: 32),
          child: Image.asset(
            'assets/imgs/image_glucose_table.png',
            width: 340,
          ),
        ),
        const SizedBox(
          height: 32,
        ),
        Text(
          getAppLocalizations(context).bottom_sheet_glucose_table_origin_info,
          style: getTextTheme(context).c2r.copyWith(
                color: getColorScheme(context).neutral80,
              ),
        ),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }
}
