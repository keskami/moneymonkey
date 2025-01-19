import 'package:flutter/material.dart';
import 'package:money_monkey/themes/color_themes.dart';

class ColoredPaddedContainer extends Container {
  ColoredPaddedContainer({
    super.key,
    super.child,
    super.decoration,
    super.padding,
    super.margin,
    super.color,
    this.width,
    this.height,
  });
  final double? width;
  final double? height;
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      margin: margin ??
          EdgeInsets.symmetric(
            vertical: screenHeight * 0.02,
          ),
      padding: padding ??
          EdgeInsets.symmetric(
            horizontal: screenWidth * 0.01,
            vertical: screenHeight * 0.02,
          ),
      height: height,
      width: width ?? double.infinity,
      decoration: decoration ??
          BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: color ?? LightTheme().pastelGreen.withValues(alpha: 0.2),
          ),
      child: child,
    );
  }
}
