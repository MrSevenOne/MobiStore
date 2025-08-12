import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData LightTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: Color(0xFFF8F9FA),
  colorScheme: ColorScheme.light(
    primary: Color(0xFF5B9EE1),
    onPrimary: Colors.black,
    secondary: Colors.white,
    surface: Color(0xFFF8F9FA),
    shadow: Color(0xFFC6DDF4),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Color(0xFF5B9EE1),
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 32),
      textStyle: GoogleFonts.inknutAntiqua(
        textStyle: TextStyle(
          fontSize: 16.0,
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    hintStyle: GoogleFonts.abhayaLibre(
      textStyle: TextStyle(
        color: Color(0xFF707B81),
        fontSize: 20,
      ),
    ),
    contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(100),
      borderSide: BorderSide.none,
    ),
  ),
  textTheme: TextTheme(
    titleLarge: GoogleFonts.abhayaLibre(
      textStyle: TextStyle(fontSize: 40.0, color: Color(0xFF1A2530)),
    ),
    titleMedium: GoogleFonts.abhayaLibre(
      textStyle: TextStyle(fontSize: 28.0, color: Colors.white),
    ),
    titleSmall: GoogleFonts.abhayaLibre(
      textStyle: TextStyle(fontSize: 24.0, color: Color(0xFF5B9EE1)),
    ),
    bodyLarge: GoogleFonts.abhayaLibre(
      textStyle: TextStyle(fontSize: 20.0, color: Color(0xFF707B81)),
    ),
    bodyMedium: GoogleFonts.abhayaLibre(textStyle: TextStyle(fontSize: 18.0,color: Colors.white),),
    bodySmall: GoogleFonts.abhayaLibre(textStyle: TextStyle(fontSize: 16,color: Color(0xFF707B81),),),
  ),

  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: const Color(0xFF5B9EE1),
    foregroundColor: Colors.white,
    elevation: 8,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(16)),
    ),
  ),
);
