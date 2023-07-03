import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ody_flutter_app/presentation/components/progress/PainterCircleProgress.dart';

class CustomCircle extends HookWidget {
  final double percentage;
  final double strokeWidth;
  final Color activeColor;
  final Color defaultColor;

  const CustomCircle({
    Key? key,
    required this.percentage,
    required this.activeColor,
    required this.defaultColor,
    this.strokeWidth = 8,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: math.pi * 7 / 6,
      child: Stack(
        children: [
          CustomPaint(
            painter: PainterCircleProgress(
              color: defaultColor,
              progress: 1.0,
              strokeWidth: strokeWidth,
            ),
            child: Container(),
          ),
          CustomPaint(
            painter: PainterCircleProgress(
              color: activeColor,
              progress: percentage,
              strokeWidth: strokeWidth,
            ),
            child: Container(),
          )
        ],
      ),
    );
  }
}
