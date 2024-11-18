import 'package:flutter/material.dart';
import 'package:money_monkey/themes/color_themes.dart';

class ContinueButton extends StatelessWidget {
  ContinueButton({
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
            borderRadius: BorderRadius.circular(10),
          ),
          margin: const EdgeInsets.symmetric(
            vertical: 10,
          ),
          height: MediaQuery.of(context).size.height * 0.04,
          child: Center(
            child: Text(
              "Continue",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ));
  }
}
