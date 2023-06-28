import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CustomCircle extends HookWidget {
  final double percentage;
  final Color activeColor;
  final Color defaultColor;

  const CustomCircle({
    Key? key,
    required this.percentage,
    required this.activeColor,
    required this.defaultColor,
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
            ),
            child: Container(),
          ),
          CustomPaint(
            painter: PainterCircleProgress(
              color: activeColor,
              progress: percentage,
            ),
            child: Container(),
          )
        ],
      ),
    );
  }
}

/// @feature: 아래가 비어있는 원형 프로그래스바
///
/// @author: 2023/05/01 2:04 PM donghwishin
class PainterCircleProgress extends CustomPainter {
  Color color;
  double progress;

  PainterCircleProgress({
    required this.progress,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..strokeWidth = 8
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = math.min(size.width / 2, size.height / 2);

    canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius), -math.pi / 2, 5 * math.pi / 3 * progress, false, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
