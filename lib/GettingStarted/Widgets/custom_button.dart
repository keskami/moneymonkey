import 'package:flutter/material.dart';
import 'package:money_monkey/themes/color_themes.dart';

class Custombutton extends StatelessWidget {
  const Custombutton({
    super.key,
    required this.text,
    required this.color,
    required this.isBordered,
  });
  final String text;
  final Color color;
  final bool isBordered;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
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
      child: TextButton(
        onPressed: () {},
        child: Text(
          text,
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w600,
            color:
                isBordered ? Colors.black : LightTheme().primaryBackgroundColor,
          ),
        ),
      ),
    );
  }
}
