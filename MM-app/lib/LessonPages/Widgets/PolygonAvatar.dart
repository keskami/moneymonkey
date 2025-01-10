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
