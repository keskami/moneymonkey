import 'package:flutter/material.dart';

class MeterBox extends StatelessWidget {
  final double screenHeight;
  final double screenWidth;

  MeterBox({required this.screenHeight, required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenHeight * 100,
      width: screenWidth * 100,
      color: Colors.blue, // You can customize the container's properties as needed
    );
  }
}