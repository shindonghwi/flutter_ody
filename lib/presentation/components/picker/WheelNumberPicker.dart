import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';

/**
 * @feature: 숫자를 선택 할 수 있는 위젯 ( 휠 픽커 )
 * @author: 2023/02/14 2:12 PM donghwishin
 */
class WheelNumberPicker extends StatefulWidget {
  final min;
  final max;
  final initialValue;

  WheelNumberPicker({required this.initialValue, this.min = 1, this.max = 100});

  @override
  _WheelNumberPickerState createState() => _WheelNumberPickerState();
}

class _WheelNumberPickerState extends State<WheelNumberPicker> {
  late int _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        NumberPicker(
          infiniteLoop: true,
          value: _currentValue,
          minValue: widget.min,
          maxValue: widget.max,
          itemCount: 5,
          selectedTextStyle: getTextTheme(context)
              .displayMedium
              ?.copyWith(color: getColorScheme(context).primary, fontWeight: FontWeight.bold),
          textStyle: getTextTheme(context).titleLarge?.copyWith(
                color: getColorScheme(context).primary.withOpacity(0.3),
              ),
          onChanged: (value) => setState(() => _currentValue = value),
        ),
      ],
    );
  }
}
