import 'package:flutter/material.dart';

class ChatBubbleContainer extends StatelessWidget {
  const ChatBubbleContainer({
    super.key,
    required this.childWidget,
    this.trianglePosition = TrianglePosition.bottom,
    this.borderWidth = 2, // Default border width
    this.borderRadius = 16, // Default border radius
  });

  final Widget childWidget;
  final TrianglePosition trianglePosition;
  final double borderWidth;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: ChatBubblePainter(
        trianglePosition: trianglePosition,
        borderWidth: borderWidth,
        borderRadius: borderRadius,
      ),
      child: Container(
        padding: trianglePosition == TrianglePosition.bottom
            ? const EdgeInsets.fromLTRB(
                10,
                10,
                10,
                20,
              )
            : const EdgeInsets.fromLTRB(
                33,
                10,
                15,
                10,
              ),
        child: childWidget,
      ),
    );
  }
}

enum TrianglePosition { bottom, left }

class ChatBubblePainter extends CustomPainter {
  final TrianglePosition trianglePosition;
  final double borderWidth;
  final double borderRadius;

  ChatBubblePainter({
    required this.trianglePosition,
    required this.borderWidth,
    required this.borderRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white // Background color of the container
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = Colors.black // Border color
      ..strokeWidth = borderWidth // Custom border width
      ..style = PaintingStyle.stroke;

    final path = Path();
    double triangleHeight = 10; // Triangle height
    double containerWidth = size.width;
    double containerHeight = size.height;

    if (trianglePosition == TrianglePosition.bottom) {
      // Draw rounded rectangle without triangle
      path.addRRect(RRect.fromRectAndCorners(
        Rect.fromLTRB(0, 0, containerWidth, containerHeight - triangleHeight),
        topLeft: Radius.circular(borderRadius),
        topRight: Radius.circular(borderRadius),
        bottomLeft: Radius.circular(borderRadius),
        bottomRight: Radius.circular(borderRadius),
      ));

      // Draw triangle separately at the bottom
      final trianglePath = Path();
      trianglePath.moveTo(
          (containerWidth / 2) - 10, containerHeight - triangleHeight);
      trianglePath.lineTo(
          containerWidth / 2, containerHeight); // Tip of the triangle
      trianglePath.lineTo(
          (containerWidth / 2) + 10, containerHeight - triangleHeight);
      trianglePath.close();

      // Draw triangle
      canvas.drawPath(trianglePath, paint);
      canvas.drawPath(trianglePath, borderPaint);
    } else if (trianglePosition == TrianglePosition.left) {
      // Draw rounded rectangle without triangle
      path.addRRect(RRect.fromRectAndCorners(
        Rect.fromLTRB(triangleHeight, 0, containerWidth, containerHeight),
        topLeft: Radius.circular(borderRadius),
        topRight: Radius.circular(borderRadius),
        bottomLeft: Radius.circular(borderRadius),
        bottomRight: Radius.circular(borderRadius),
      ));

      // Draw triangle separately on the left
      final trianglePath = Path();
      trianglePath.moveTo(triangleHeight, (containerHeight / 2) - 5);
      trianglePath.lineTo(0, containerHeight / 2 + 7); // Tip of the triangle
      trianglePath.lineTo(triangleHeight, (containerHeight / 2) + 7);
      trianglePath.close();

      // Draw triangle
      canvas.drawPath(trianglePath, paint);
      canvas.drawPath(trianglePath, borderPaint);
    }

    // Draw the main bubble (rounded rectangle)
    canvas.drawPath(path, paint);

    // Draw the border with the specified stroke width
    canvas.drawPath(path, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
