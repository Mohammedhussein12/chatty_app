import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primary = Color(0xff3598DB);
  static const Color white = Color(0xffFFFFFF);
  static const Color black = Color(0xff141922);
  static const Color grey = Color(0xff7F7F7F);
  static const Color lightGrey = Color.fromARGB(255, 237, 237, 237);
  static const Color red = Color(0xffFF0000);
  static final ThemeData lightTheme = ThemeData(
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: primary),
    ),
    appBarTheme: const AppBarTheme(
        foregroundColor: white,
        centerTitle: true,
        backgroundColor: Colors.transparent),
    primaryColor: primary,
    scaffoldBackgroundColor: Colors.transparent,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      elevation: 8,
      iconSize: 35,
      backgroundColor: primary,
      shape: CircleBorder(),
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
