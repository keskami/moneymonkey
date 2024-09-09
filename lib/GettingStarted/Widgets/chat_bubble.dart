import 'package:flutter/material.dart';

class ChatBubbleContainer extends StatelessWidget {
  const ChatBubbleContainer({
    super.key,
    required this.text,
    required this.childWidget,
    this.trianglePosition = TrianglePosition.bottom,
    this.triangleWidth = 20, // Default triangle width
    this.borderWidth = 2, // Default border width
  });

  final String text;
  final Widget childWidget;
  final TrianglePosition trianglePosition;
  final double triangleWidth;
  final double borderWidth;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: ChatBubblePainter(
        trianglePosition: trianglePosition,
        triangleWidth: triangleWidth,
        borderWidth: borderWidth,
      ),
      child: Container(
        padding: trianglePosition == TrianglePosition.bottom
            ? const EdgeInsets.fromLTRB(
                //If it's bottom. The lower space is inadequate otherwise
                15,
                10,
                15,
                20,
              )
            : const EdgeInsets.fromLTRB(
                //If it's bottom. The lower space is inadequate otherwise
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
  final double triangleWidth;
  final double borderWidth;

  ChatBubblePainter({
    required this.trianglePosition,
    required this.triangleWidth,
    required this.borderWidth,
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

    // Define dimensions of the triangle
    double triangleHeight = 10;
    double containerWidth = size.width;
    double containerHeight = size.height;

    if (trianglePosition == TrianglePosition.bottom) {
      // Draw the main rectangle of the chat bubble with a triangle at the bottom center
      path.moveTo(0, 0);
      path.lineTo(containerWidth, 0);
      path.lineTo(containerWidth, containerHeight - triangleHeight);

      // Triangle at the bottom center
      path.lineTo((containerWidth / 2) + (triangleWidth / 2),
          containerHeight - triangleHeight);
      path.lineTo(containerWidth / 2, containerHeight); // Tip of the triangle
      path.lineTo((containerWidth / 2) - (triangleWidth / 2),
          containerHeight - triangleHeight);

      // Continue the path around the rectangle
      path.lineTo(0, containerHeight - triangleHeight);
      path.close();
    } else if (trianglePosition == TrianglePosition.left) {
      // Draw the main rectangle of the chat bubble with a triangle on the left side
      path.moveTo(triangleWidth, 0);
      path.lineTo(containerWidth, 0);
      path.lineTo(containerWidth, containerHeight);
      path.lineTo(triangleWidth, containerHeight);

      // Triangle on the left side
      path.lineTo(triangleWidth, (containerHeight / 2) + (triangleHeight / 2));
      path.lineTo(0, containerHeight / 2); // Tip of the triangle
      path.lineTo(triangleWidth, (containerHeight / 2) - (triangleHeight / 2));

      // Continue the path around the rectangle
      path.lineTo(triangleWidth, 0);
      path.close();
    }

    // Draw the background
    canvas.drawPath(path, paint);

    // Draw the border with the specified stroke width
    canvas.drawPath(path, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
