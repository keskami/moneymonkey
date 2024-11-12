import 'package:flutter/material.dart';
import 'package:money_monkey/themes/color_themes.dart';

class NextButton extends StatelessWidget {
  NextButton({
    super.key,
    required this.pages,
    required this.nextPage,
    required this.isEnabled,
  });
  final int pages;
  final Function() nextPage;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
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
              "CONTINUE",
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ));
  }
}
