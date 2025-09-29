import 'package:flutter/material.dart';
import 'package:money_monkey/themes/color_themes.dart';

class Custombutton extends StatelessWidget {
  const Custombutton({
    super.key,
    required this.text,
    required this.color,
    required this.isBordered,
    required this.toNextPage,
    this.fontSize = 25.0,
  });
  final String text;
  final Color color;
  final bool isBordered;
  final Function() toNextPage;
  final double fontSize;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: toNextPage,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 12,
        ),
        margin: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: color,
          border: isBordered
              ? Border.all(
                  color: Colors.black,
                )
              : null,
          borderRadius: BorderRadius.circular(
            20,
          ),
        ),
        width: double.infinity,
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.w600,
              color: isBordered
                  ? Colors.black
                  : LightTheme().primaryBackgroundColor,
            ),
          ),
        ),
      ),
    );
  }
}
