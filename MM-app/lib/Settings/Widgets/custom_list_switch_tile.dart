import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomListSwitchTile extends StatelessWidget {
  const CustomListSwitchTile({
    super.key,
    required this.title,
    required this.onTap,
    required this.val,
  });
  final String title;
  final bool val;
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
      trailing: Switch(
        value: val,
        activeColor: Colors.grey,
        trackOutlineColor: val ? null : WidgetStatePropertyAll(Colors.black),
        thumbColor: val
            ? WidgetStatePropertyAll(Colors.white)
            : WidgetStatePropertyAll(Colors.grey),
        onChanged: (value) {
          onTap();
        },
      ),
    );
  }
}
