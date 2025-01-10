import 'dart:math';
import 'package:flutter/material.dart';
import 'package:money_monkey/themes/color_themes.dart';

class PolygonAvatar extends StatelessWidget {
  final double size;
  final Color backgroundColor;
  final Widget icon;
  final int sides;
  final bool isActivated;

  const PolygonAvatar({
    super.key,
    this.size = 50,
    required this.backgroundColor,
    required this.icon,
    this.sides = 6,
    required this.isActivated,
  });

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: PolygonClipper(sides: sides),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              !isActivated
                  ? LightTheme().primaryBlue
                  : backgroundColor, // Creates a lighter shade
              backgroundColor,
            ],
          ),
        ),
        child: Center(
          child: icon,
        ),
      ),
    );
  }
}

class PolygonClipper extends CustomClipper<Path> {
  final int sides;

  PolygonClipper({required this.sides});

  @override
  Path getClip(Size size) {
    var path = Path();
    var radius = size.width / 2;
    var center = Offset(size.width / 2, size.height / 2);
    var angle = (2 * pi) / sides;

    // Start from the top by rotating -90 degrees (or -π/2 radians)
    var startAngle = -pi / 2;

    path.moveTo(
      center.dx + radius * cos(startAngle),
      center.dy + radius * sin(startAngle),
    );

    for (int i = 1; i < sides; i++) {
      double x = center.dx + radius * cos(startAngle + angle * i);
      double y = center.dy + radius * sin(startAngle + angle * i);
      path.lineTo(x, y);
    }

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class Polygon {
  final Offset center;
  final int index;
  final bool isActivated;

  Polygon(this.center, this.index, this.isActivated);
}

class PolygonConnectorPainter extends CustomPainter {
  final List<Polygon> polygons;
  final double scrollOffset;

  PolygonConnectorPainter({required this.polygons, required this.scrollOffset});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey // Color of the lines
      ..strokeWidth = 2.0;

    // Adjust polygon centers based on scroll offset
    List<Offset> adjustedCenters = polygons.map((polygon) {
      return Offset(polygon.center.dx, polygon.center.dy - scrollOffset);
    }).toList();

    // Draw connecting lines between adjacent polygons
    for (int i = 0; i < adjustedCenters.length - 1; i++) {
      Offset center1 = adjustedCenters[i];
      Offset center2 = adjustedCenters[i + 1];
      Path path = Path();
      path.moveTo(center1.dx, center1.dy);
      path.lineTo(center2.dx, center2.dy);
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true; // Repaint whenever scroll offset changes
  }
}
