import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomRowTileButton extends StatelessWidget {
  const CustomRowTileButton({
    super.key,
    required this.title,
    required this.onTap,
    required this.rowChildren,
  });
  final String title;
  final void Function() onTap;
  final List<Widget> rowChildren;
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return ListTile(
      leading: Text(
        title,
        style: GoogleFonts.baloo2(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      trailing: SizedBox(
        width: screenWidth * 0.3,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: rowChildren,
        ),
      ),
    );
  }
}
