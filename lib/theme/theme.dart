import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    background: Colors.white,
    primary: Colors.grey.shade200,
  ),
  textTheme: GoogleFonts.dmSansTextTheme(),
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    background: Colors.grey.shade900,
    primary: Colors.grey.shade800,
  ),
  textTheme: GoogleFonts.dmSansTextTheme().apply(
    bodyColor: Colors.white, // Set the default text color in dark mode
    displayColor: Colors.white, // Set the display text color in dark mode
  ),
  inputDecorationTheme: InputDecorationTheme(
    labelStyle: TextStyle(
      color: Colors.white, // Set the color of label text in dark mode
    ),
  ),
);
