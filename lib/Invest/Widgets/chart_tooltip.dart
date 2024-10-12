import 'package:flutter/material.dart';

class RoundedTextBackgroundPainter extends CustomPainter {
  final String text;
  final TextStyle style;
  final Color backgroundColor;
  final double padding;

  RoundedTextBackgroundPainter({
    required this.text,
    required this.style,
    required this.backgroundColor,
    this.padding = 4.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.left,
    );

    textPainter.layout();

    // Draw rounded rectangle background
    final paint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;

    final rect = Rect.fromLTWH(
      0,
      0,
      textPainter.width + padding * 2,
      textPainter.height + padding * 2,
    );

    final rRect = RRect.fromRectAndRadius(
        rect, Radius.circular(12.0)); // Adjust radius as needed
    canvas.drawRRect(rRect, paint);

    // Draw the text on top of the background
    textPainter.paint(canvas, Offset(padding, padding));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
