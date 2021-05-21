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
      ..lineTo(0, y)
      ..quadraticBezierTo(x / 4, y - 5, x / 2 - 20, 10)
      ..quadraticBezierTo(x / 2 - 10, 0, x / 2, 0)
      ..quadraticBezierTo(x / 2 + 10, 0, x / 2 + 20, 10)
      ..quadraticBezierTo(3 * x / 4, y - 5, x, y)
      ..lineTo(x, y)
      ..lineTo(0, y);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
