import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class IndicatorDot extends HookWidget {
  final bool isSelected;

  IndicatorDot({this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    final dotSize = isSelected ? 15.0 : 7.0;
    final dotColor = isSelected ? Colors.blue : Colors.grey;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        width: dotSize,
        height: 7.0,
        decoration: BoxDecoration(
          color: dotColor,
          borderRadius: BorderRadius.circular(100.0),
        ),
      ),
    );
  }
}
