import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class CirclePainter extends CustomPainter {
  final double percentage;
  final Color color;
  final Color background;
  CirclePainter(this.percentage, this.color,this.background);

  @override
  void paint(Canvas canvas, Size size) {
    double strokeWidth = 10;
    Paint backgroundPaint = Paint()
      ..color = background
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    Paint progressPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = size.width / 2 - strokeWidth / 2;
    canvas.drawCircle(center, radius, backgroundPaint);

    double sweepAngle = 2 * pi * percentage;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      sweepAngle,
      false,
      progressPaint,
    );
  }
  
   @override
  bool shouldRepaint(CirclePainter oldDelegate) => oldDelegate.percentage != percentage;
}