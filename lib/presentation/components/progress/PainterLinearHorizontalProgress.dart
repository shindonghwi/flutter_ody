import 'package:flutter/material.dart';

class PainterLinearHorizontalProgress extends CustomPainter {
  final double progress;
  final Color defaultColor;
  final Color activeColor;
  final double radius;

  PainterLinearHorizontalProgress({
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

    final activeWidth = progress * size.width;
    final activePath = Path()
      ..addRRect(
        RRect.fromRectAndCorners(
          Rect.fromLTWH(0, 0, activeWidth, size.height),
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
