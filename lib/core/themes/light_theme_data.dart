import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_setup/core/core.dart';

ThemeData getLightThemeData() {
  return ThemeData(
    useMaterial3: true,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: AppColors.primary,
    ),
    scaffoldBackgroundColor: Colors.white,
    textTheme: TextTheme(
      bodyLarge: GoogleFonts.plusJakartaSans(
        color: Colors.black,
        fontWeight: FontWeight.w500,
        fontSize: 20,
      ),
      bodyMedium: GoogleFonts.plusJakartaSans(
        color: Colors.black,
        fontWeight: FontWeight.w500,
        fontSize: 14,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: EdgeInsets.all(10),
      errorStyle: GoogleFonts.plusJakartaSans(
        color: Colors.redAccent,
        fontWeight: FontWeight.w400,
        fontSize: 14,
      ),
      hintStyle: GoogleFonts.plusJakartaSans(
        color: AppColors.textGrey,
        fontWeight: FontWeight.normal,
        fontSize: 14,
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(color: Color(0xFFE1E4EA)),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(color: Color(0xFFE1E4EA)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(color: Color(0xFFE1E4EA)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(color: Color(0xFFE1E4EA)),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(color: AppColors.error),
      ),
      filled: true,
      fillColor: Colors.white,
    ),
  );
}
