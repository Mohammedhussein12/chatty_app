import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primary = Color(0xff3598DB);
  static const Color white = Color(0xffFFFFFF);
  static const Color black = Color(0xff141922);
  static const Color grey = Color(0xffC8C9CB);
  static const Color red = Color(0xffFF0000);
  static final ThemeData lightTheme = ThemeData(
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: primary),
    ),
    appBarTheme: const AppBarTheme(
        centerTitle: true, backgroundColor: Colors.transparent),
    primaryColor: primary,
    scaffoldBackgroundColor: Colors.transparent,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      foregroundColor: white,
      backgroundColor: primary,
      shape: CircleBorder(
        side: BorderSide(width: 4, color: white),
      ),
    ),
    textTheme: TextTheme(
      titleLarge: GoogleFonts.poppins(
        color: white,
        fontWeight: FontWeight.bold,
        fontSize: 22,
      ),
      titleMedium: GoogleFonts.poppins(
        color: black,
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
      titleSmall: GoogleFonts.poppins(
        color: black,
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
      headlineSmall: GoogleFonts.inter(
        color: black,
        fontWeight: FontWeight.w400,
        fontSize: 20,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
      ),
    ),
  );
}
