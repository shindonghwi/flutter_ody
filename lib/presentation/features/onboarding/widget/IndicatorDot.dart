import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ody_flutter_app/presentation/ui/colors.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';

class IndicatorDot extends HookWidget {
  final bool isSelected;

  const IndicatorDot({super.key, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    final dotSize = isSelected ? 15.0 : 7.0;
    final dotColor = isSelected ? getColorScheme(context).primary100 : getColorScheme(context).neutral30;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
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
