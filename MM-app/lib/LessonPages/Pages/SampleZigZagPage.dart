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
    // Ensure the size is square to maintain a 45-degree angle
    assert(size.width == size.height,
        'Container must be square for a 45-degree slant');

    final paint = Paint()
      ..color = isActivated ? Colors.blue : Colors.grey.shade300
      ..strokeWidth = 8
      ..style = PaintingStyle.stroke;

    final path = Path();
    if (RightToLeft) {
      // From bottom-left to top-right
      path.moveTo(0, size.height - 20);
      path.lineTo(size.width, 0);
    } else {
      // From top-left to bottom-right
      path.moveTo(0, 0);
      path.lineTo(size.width, size.height - 20);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // Redraw only if isActivated or RightToLeft changes
    return oldDelegate is SlantLinePainter &&
        (oldDelegate.isActivated != isActivated ||
            oldDelegate.RightToLeft != RightToLeft);
  }
}
