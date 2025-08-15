import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData DarkTheme = ThemeData(
  appBarTheme: AppBarTheme(
    titleTextStyle: GoogleFonts.aBeeZee(
      textStyle: const TextStyle(fontSize: 20.0, color: Colors.white),
    ),
    backgroundColor: const Color(0xFF1A1A1A),
  ),
  brightness: Brightness.dark,
  scaffoldBackgroundColor: const Color(0xFF121212),
  colorScheme: const ColorScheme.dark(
    primary: Color(0xFF5B9EE1),
    onPrimary: Colors.white,
    secondary: Color(0xFF1E1E1E),
    surface: Color(0xFF1E1E1E),
    shadow: Color(0xFF000000),
    error: Colors.redAccent,
    outline: Color(0xFF2C2C2C),
  ),
  iconTheme: const IconThemeData(
    color: Colors.white70,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF5B9EE1),
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 32),
      textStyle: GoogleFonts.aBeeZee(
        textStyle: const TextStyle(
          fontSize: 16.0,
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    hintStyle: GoogleFonts.aBeeZee(
      textStyle: const TextStyle(
        color: Colors.white60,
        fontSize: 14,
      ),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
    filled: true,
    fillColor: const Color(0xFF1E1E1E),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(100),
      borderSide: BorderSide.none,
    ),
  ),
  textTheme: TextTheme(
    titleLarge: GoogleFonts.aBeeZee(
      textStyle: const TextStyle(fontSize: 36.0, color: Colors.white),
    ),
    titleMedium: GoogleFonts.aBeeZee(
      textStyle: const TextStyle(fontSize: 24.0, color: Colors.white),
    ),
    titleSmall: GoogleFonts.aBeeZee(
      textStyle: const TextStyle(fontSize: 20.0, color: Color(0xFF5B9EE1)),
    ),
    bodyLarge: GoogleFonts.aBeeZee(
      textStyle: const TextStyle(fontSize: 18.0, color: Colors.white),
    ),
    bodyMedium: GoogleFonts.aBeeZee(
      textStyle: const TextStyle(fontSize: 16.0, color: Colors.white70),
    ),
    bodySmall: GoogleFonts.aBeeZee(
      textStyle: const TextStyle(fontSize: 14, color: Colors.white54),
    ),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Color(0xFF5B9EE1),
    foregroundColor: Colors.white,
    elevation: 8,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(16)),
    ),
  ),
);
