import 'dart:math' as math;

import 'package:flutter/material.dart';

/// @feature: 아래가 비어있는 원형 프로그래스바
///
/// @author: 2023/05/01 2:04 PM donghwishin
class PainterCircleProgress extends CustomPainter {
  double progress;

  PainterCircleProgress({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.white.withOpacity(0.3)
      ..strokeWidth = 8
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = math.min(size.width / 2, size.height / 2);

    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -math.pi / 2,
        5 * math.pi / 3 * progress, false, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
