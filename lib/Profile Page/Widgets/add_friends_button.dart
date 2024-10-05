import 'package:flutter/material.dart';
import 'package:money_monkey/themes/color_themes.dart';

class AddFriendsButton extends StatelessWidget {
  const AddFriendsButton({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.4,
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(
          width: 6,
          color: Colors.white,
        ),
        borderRadius: BorderRadius.circular(10),
        color: LightTheme().primaryBackgroundColor,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.add_outlined,
            color: LightTheme().primaryBlue,
          ),
          Text(
            "ADD FRIENDS",
            style: TextStyle(
              fontSize: 17,
              color: LightTheme().primaryBlue,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
