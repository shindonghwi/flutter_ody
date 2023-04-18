import 'package:flutter/material.dart';

class HomeBackgroundArc extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color(0xFF4E87FF)
      ..style = PaintingStyle.fill;

    final maxHeight = size.height;
    final maxWidth = size.width;
    final handlePointX = size.width / 2;
    final handlePointY = maxHeight * 1.15;

    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(maxWidth, 0)
      ..lineTo(maxWidth, maxHeight)
      ..lineTo(0, maxHeight)
      ..moveTo(0, maxHeight)
      ..quadraticBezierTo(handlePointX, handlePointY, maxWidth, maxHeight)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
