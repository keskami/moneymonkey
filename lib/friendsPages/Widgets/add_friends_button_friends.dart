import 'package:flutter/material.dart';
import 'package:money_monkey/themes/color_themes.dart';

class AddFriendsButtonFriends extends StatefulWidget {
  bool follows;

  AddFriendsButtonFriends({
    Key? key,
    required this.follows,
  }) : super(key: key);

  @override
  _AddFriendsButtonFriendsState createState() => _AddFriendsButtonFriendsState();
}

class _AddFriendsButtonFriendsState extends State<AddFriendsButtonFriends> {
  
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
      child: GestureDetector(
        onTap: () {
          setState(() {
            widget.follows = !widget.follows;
          });
        
        },
        child: widget.follows ?  Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check,
              color: LightTheme().primaryGreen,
            ),
            SizedBox(width: 10),
            Text(
              "Following",
              style: TextStyle(
                fontSize: 17,
                color: LightTheme().primaryGreen,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ): Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add_outlined,
              color: LightTheme().primaryBlue,
            ),
            SizedBox(width: 10),
            Text(
              "Add Friend",
              style: TextStyle(
                fontSize: 17,
                color: LightTheme().primaryBlue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
