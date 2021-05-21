import 'package:flutter/material.dart';

class StartQuizButton extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double x = size.width;
    double y = size.height;

    Path path = Path();
    Paint paint = Paint()
      ..color = Colors.redAccent
      ..style = PaintingStyle.fill;

    path
      ..lineTo(0, 10)
      ..lineTo(x / 2, 0)
      ..lineTo(x, 10)
      ..lineTo(x, y)
      ..lineTo(0, y)
      ..lineTo(0, 10);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
