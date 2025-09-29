import 'package:flutter/material.dart';
import 'package:money_monkey/themes/color_themes.dart';

class NextButton extends StatelessWidget {
  NextButton({
    super.key,
    required this.nextPage,
    required this.isEnabled,
    this.text = "CONTINUE",
  });
  final String text;
  final Function() nextPage;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return screenWidth > screenHeight
        ? webDisplay(context, screenHeight, screenWidth)
        : mobileDisplay(context);
  }

  GestureDetector mobileDisplay(BuildContext context) {
    return GestureDetector(
        onTap: isEnabled ? nextPage : null,
        child: Container(
          decoration: BoxDecoration(
            color: isEnabled ? LightTheme().primaryBlue : Colors.grey,
            borderRadius: BorderRadius.circular(15),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 12,
          ),
          margin: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.065,
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ));
  }

  GestureDetector webDisplay(
      BuildContext context, double screenHeight, double screenWidth) {
    return GestureDetector(
        onTap: isEnabled ? nextPage : null,
        child: Container(
          decoration: BoxDecoration(
            color: isEnabled ? LightTheme().primaryBlue : Colors.grey[300],
            borderRadius: BorderRadius.circular(15),
          ),
          margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 12,
          ),
          width: screenWidth * 0.1,
          height: screenHeight * 0.07,
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ));
  }
}
