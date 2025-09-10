import 'package:mobi_store/export.dart';

// 🔥 Light Theme
ThemeData LightTheme = ThemeData(
  appBarTheme: AppBarTheme(
    titleTextStyle: GoogleFonts.aBeeZee(
      textStyle: const TextStyle(fontSize: 20.0, color: Colors.black),
    ),
  ),
  brightness: Brightness.light,
  scaffoldBackgroundColor: const Color(0xFFF8F9FA),
  colorScheme: const ColorScheme.light(
    primary: Color(0xFF5B9EE1),
    onPrimary: Colors.black,
    secondary: Color(0xFFFFFFFF),
    onSecondary: Color(0xFFFFFFFF),
    surface: Color(0xFFF8F9FA),
    shadow: Color(0xFF707B81),
    error: Colors.red,
    outline: Color(0xFFE9EDEF),
  ),
  iconTheme: const IconThemeData(
    color: Color(0xFF707B81),
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

  // 🔹 TextField design (Light)
  inputDecorationTheme: InputDecorationTheme(
    hintStyle: GoogleFonts.aBeeZee(
      textStyle: const TextStyle(
        color: Color(0xFF707B81),
        fontSize: 14,
      ),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(color: Color(0xFFE9EDEF)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(color: Color(0xFF5B9EE1), width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(color: Colors.red, width: 2),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(color: Colors.red, width: 2),
    ),
  ),

  textTheme: TextTheme(
    titleLarge: GoogleFonts.aBeeZee(
      textStyle: const TextStyle(fontSize: 36.0, color: Color(0xFF1A2530)),
    ),
    titleMedium: GoogleFonts.aBeeZee(
      textStyle: const TextStyle(fontSize: 24.0, color: Colors.white),
    ),
    titleSmall: GoogleFonts.aBeeZee(
      textStyle: const TextStyle(fontSize: 20.0, color: Color(0xFF5B9EE1)),
    ),
    bodyLarge: GoogleFonts.aBeeZee(
      textStyle: const TextStyle(fontSize: 18.0, color: Colors.black),
    ),
    bodyMedium: GoogleFonts.aBeeZee(
      textStyle: const TextStyle(fontSize: 16.0, color: Colors.black),
    ),
    bodySmall: GoogleFonts.aBeeZee(
      textStyle: const TextStyle(fontSize: 14, color: Color(0xFF707B81)),
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
