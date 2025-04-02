import 'package:flutter/material.dart';

class ShadowedContainer extends Container {
  ShadowedContainer({
    super.key,
    super.child,
    super.width,
    super.height,
    super.decoration,
    super.margin,
    super.padding,
    super.constraints,
  });

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: padding ??
          EdgeInsets.symmetric(
            horizontal: screenWidth * 0.02,
            vertical: screenHeight * 0.02,
          ),
      margin: margin ??
          EdgeInsets.symmetric(
            vertical: screenHeight * 0.02,
          ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: child,
    );
  }
}
