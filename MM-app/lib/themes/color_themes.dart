import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemes {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    textTheme: GoogleFonts.fredokaTextTheme(
      ThemeData.light().textTheme.apply(
            bodyColor: Colors.black,
            displayColor: Colors.black,
          ),
    ),
    scaffoldBackgroundColor: const Color.fromARGB(255, 244, 247, 249),
    switchTheme: SwitchThemeData(),
    appBarTheme: AppBarTheme(
      backgroundColor: const Color.fromARGB(255, 244, 247, 249),
      titleTextStyle: TextStyle(
        color: Colors.black,
      ),
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
    ),
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
    dividerTheme: DividerThemeData(
      color: Colors.grey,
      thickness: 1,
    ),
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: const Color.fromARGB(255, 135, 206, 235),
      onPrimary: Colors.white,
      secondary: const Color.fromARGB(255, 133, 220, 64),
      onSecondary: Colors.black,
      error: Colors.red,
      onError: Colors.white,
      surface: Colors.white,
      onSurface: Colors.black,
      inverseSurface: Colors.black,
      onInverseSurface: Colors.white,
    ),
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
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
      surface: Colors.black,
      onSurface: Colors.black,
      inverseSurface: const Color.fromARGB(255, 244, 247, 249),
      onInverseSurface: const Color.fromARGB(255, 244, 247, 249),
    ),
  );
}

class LightTheme {
  Color primaryBackgroundColor = const Color.fromARGB(255, 244, 247, 249);
  Color primaryBlue = const Color.fromARGB(255, 135, 206, 235);
  Color primaryGreen = const Color.fromARGB(255, 133, 220, 64);
  Color pastelGreen = Color.fromARGB(255, 137, 220, 143);
  Color pastelRed = Color.fromARGB(255, 255, 105, 105);
}

class DarkTheme {
  Color primaryBackgroundColor = const Color.fromARGB(255, 0, 0, 0);
  Color primaryBlue = const Color.fromARGB(255, 135, 206, 235);
  Color primaryGreen = const Color.fromARGB(255, 133, 220, 64);
}
