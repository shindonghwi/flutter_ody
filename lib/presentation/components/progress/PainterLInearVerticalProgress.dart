import 'package:flutter/material.dart';
import 'dart:math' as math;

class PainterLinearVerticalProgress extends CustomPainter {
  final double progress;
  final Color defaultColor;
  final Color activeColor;
  final double radius;

  PainterLinearVerticalProgress({
    required this.progress,
    required this.defaultColor,
    required this.activeColor,
    required this.radius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final progressBarRect = Rect.fromLTWH(0, 0, size.width, size.height);

    final defaultPaint = Paint()
      ..color = defaultColor
      ..strokeCap = StrokeCap.round;

    final activePaint = Paint()
      ..color = activeColor
      ..strokeCap = StrokeCap.round;

    final defaultPath = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          progressBarRect,
          Radius.circular(radius),
        ),
      );

    final activeHeight = progress * size.height;
    final activePath = Path()
      ..addRRect(
        RRect.fromRectAndCorners(
          Rect.fromLTWH(0, size.height - activeHeight, size.width, activeHeight),
          topLeft: Radius.circular(radius),
          topRight: Radius.circular(radius),
          bottomLeft: Radius.circular(radius),
          bottomRight: Radius.circular(radius),
        ),
      );

    canvas.drawPath(defaultPath, defaultPaint);
    canvas.drawPath(activePath, activePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}