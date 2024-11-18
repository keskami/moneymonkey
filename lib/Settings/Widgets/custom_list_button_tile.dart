import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomListButtonTile extends StatelessWidget {
  const CustomListButtonTile({
    super.key,
    required this.title,
    required this.onTap,
  });
  final String title;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    bool val = true;
    return ListTile(
      leading: Text(
        title,
        style: GoogleFonts.baloo2(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      trailing: IconButton(
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
