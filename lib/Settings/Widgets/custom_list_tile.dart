import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    required this.title,
    required this.isToggle,
    required this.onTap,
  });
  final String title;
  final bool isToggle;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(
        title,
        style: GoogleFonts.baloo2(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      trailing: isToggle
          ? Switch(
              value: true,
              onChanged: (value) {},
            )
          : IconButton(
              onPressed: onTap,
              icon: Icon(
                Icons.arrow_forward,
                color: Colors.black,
                size: 30,
              )),
    );
    ;
  }
}
