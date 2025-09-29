// slant_line_painter.dart
import 'package:flutter/material.dart';

class SlantLinePainter extends CustomPainter {
  final bool RightToLeft;
  final bool isActivated;

  SlantLinePainter({
    required this.RightToLeft,
    required this.isActivated,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = isActivated ? Colors.blue : Colors.grey.shade300
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;
//Bhavya: Changed here to get height-25.
    if (RightToLeft) {
      canvas.drawLine(
          Offset(size.width, 0), Offset(0, size.height - 25), paint);
    } else {
      canvas.drawLine(
          Offset(0, 0), Offset(size.width, size.height - 25), paint);
    }
  }

  @override
  bool shouldRepaint(SlantLinePainter oldDelegate) => false;
}