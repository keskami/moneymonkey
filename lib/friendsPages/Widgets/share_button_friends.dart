import 'package:flutter/material.dart';
import 'package:money_monkey/themes/color_themes.dart';

class ShareButtonFriends extends StatelessWidget {
  const ShareButtonFriends({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(
          width: 6,
          color: Colors.white,
        ),
        borderRadius: BorderRadius.circular(10),
        color: LightTheme().primaryBackgroundColor,
      ),
      child: Icon(
        Icons.ios_share,
        color: LightTheme().primaryBlue,
      ),
    );
  }
}
