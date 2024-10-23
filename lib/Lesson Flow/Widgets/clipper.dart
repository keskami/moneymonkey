import 'package:flutter/material.dart';

class CurvedHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CurvedClipper(), // Custom clipper to create the curve
      child: Container(
        height: 150,
        color: const Color(0xFFFFEB99), // The yellow background
        child: Center(
          child: Text(
            'Market',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontFamily: 'Baloo 2',
            ),
          ),
        ),
      ),
    );
  }
}

// Define a custom clipper to create the curved shape
class CurvedClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    // Start from the top-left corner
    path.lineTo(0.0, size.height - 50);

    // Create a curve
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 50);

    // Line to the top-right corner
    path.lineTo(size.width, 0.0);

    // Close the path
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
