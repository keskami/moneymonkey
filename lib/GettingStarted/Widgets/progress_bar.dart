import 'package:flutter/material.dart';
import 'package:money_monkey/themes/color_themes.dart';

class CustomProgressBar extends StatelessWidget {
  final double progress; // Progress value from 0.0 to 1.0

  const CustomProgressBar({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 20,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(200),
        color: Colors.white,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: SizedBox(
        width: 20,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(200),
            color: LightTheme().primaryBlue,
          ),
        ),
      ),
    );
  }
}
