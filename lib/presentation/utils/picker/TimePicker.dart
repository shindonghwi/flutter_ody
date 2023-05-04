import 'package:flutter/material.dart';
import 'package:odac_flutter_app/presentation/ui/colors.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';

class TimePicker{
  static Future<TimeOfDay?> show(BuildContext context) async {
    final TimeOfDay? result = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.dial,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            timePickerTheme: TimePickerThemeData(
              backgroundColor: getColorScheme(context).white,
              dialHandColor: getColorScheme(context).white,
              dialBackgroundColor: getColorScheme(context).primary80.withOpacity(0.2),
              dialTextColor: MaterialStateColor.resolveWith(
                    (states) => states.contains(MaterialState.selected)
                    ? getColorScheme(context).primary100
                    : Colors.black,
              ),
            ),
            colorScheme: ColorScheme.light(
              primary: getColorScheme(context).primary100,
              onSurface: getColorScheme(context).primary100,
            ),
          ),
          child: child!,
        );
      },
    );

    return result;
  }
}