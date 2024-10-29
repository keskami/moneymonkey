import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemes {
  static final LightTheme = ThemeData(
    textTheme: GoogleFonts.fredokaTextTheme(),
    scaffoldBackgroundColor: const Color.fromARGB(255, 244, 247, 249),
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: const Color.fromARGB(255, 135, 206, 235),
      onPrimary: const Color.fromARGB(255, 135, 206, 235),
      secondary: const Color.fromARGB(255, 133, 220, 64),
      onSecondary: const Color.fromARGB(255, 133, 220, 64),
      error: Colors.red,
      onError: Colors.red,
      surface: const Color.fromARGB(255, 244, 247, 249),
      onSurface: const Color.fromARGB(255, 244, 247, 249),
    ),
  );
  static final DarkTheme = ThemeData(
    textTheme: GoogleFonts.fredokaTextTheme(),
    scaffoldBackgroundColor: const Color.fromARGB(255, 0, 0, 0),
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: const Color.fromARGB(255, 135, 206, 235),
      onPrimary: const Color.fromARGB(255, 135, 206, 235),
      secondary: const Color.fromARGB(255, 133, 220, 64),
      onSecondary: const Color.fromARGB(255, 133, 220, 64),
      error: Colors.red,
      onError: Colors.red,
      surface: const Color.fromARGB(255, 244, 247, 249),
      onSurface: const Color.fromARGB(255, 244, 247, 249),
    ),
  );
}

class LightTheme {
  Color primaryBackgroundColor = const Color.fromARGB(255, 244, 247, 249);
  Color primaryBlue = const Color.fromARGB(255, 135, 206, 235);
  Color primaryGreen = const Color.fromARGB(255, 133, 220, 64);
}

class DarkTheme {
  Color primaryBackgroundColor = const Color.fromARGB(255, 0, 0, 0);
  Color primaryBlue = const Color.fromARGB(255, 135, 206, 235);
  Color primaryGreen = const Color.fromARGB(255, 133, 220, 64);
}
