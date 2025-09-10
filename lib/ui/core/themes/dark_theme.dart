import 'package:mobi_store/export.dart';

ThemeData DarkTheme = ThemeData(
  appBarTheme: AppBarTheme(
    titleTextStyle: GoogleFonts.aBeeZee(
      textStyle: const TextStyle(fontSize: 20.0, color: Colors.white),
    ),
    backgroundColor: const Color(0xFF1A2530),
  ),
  brightness: Brightness.dark,
  scaffoldBackgroundColor: const Color(0xFF1A2530),
  colorScheme: const ColorScheme.dark(
    primary: Color(0xFF5B9EE1),
    onPrimary: Colors.white,
    secondary: Color(0xFF161F28),
    onSecondary: Color(0xFFFFFFFF),
    surface: Color(0xFF1E1E1E),
    shadow: Color(0xFF707B81),
    error: Color.fromARGB(255, 193, 68, 59),
    outline: Color(0xFF161F28),
    
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

  // 🔹 TextField design (Dark)
  inputDecorationTheme: InputDecorationTheme(
    hintStyle: GoogleFonts.aBeeZee(
      textStyle: const TextStyle(
        color: Color(0xFFB0BEC5),
        fontSize: 14,
      ),
    ),
    labelStyle: GoogleFonts.aBeeZee(
      textStyle: const TextStyle(color: Colors.white),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
    filled: true,
    fillColor: Color(0xFF202E3C),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(color: Color(0xFF161F28)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(color: Color(0xFF5B9EE1), width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(color: Colors.redAccent, width: 2),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(color: Colors.redAccent, width: 2),
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
      textStyle: const TextStyle(fontSize: 16.0, color: Colors.white),
    ),
    bodySmall: GoogleFonts.aBeeZee(
      textStyle: const TextStyle(fontSize: 14, color: Color(0xFFB0BEC5)),
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
