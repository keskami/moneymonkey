import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TimelineToggle extends StatelessWidget {
  const TimelineToggle({
    super.key,
    required this.onToggle,
    required this.duration,
  });
  final Function(String a) onToggle;
  final String duration;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      width: 20,
      child: TextButton(
        onPressed: onToggle(duration),
        child: Text(
          duration,
          style: GoogleFonts.baloo2(fontSize: 16),
        ),
      ),
    );
  }
}
