import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Primary colors
  static const Color primaryA0 = Color(0xFFFFC629);  // Bright yellow
  static const Color primaryA10 = Color(0xFFFFD24D); // Light yellow
  static const Color primaryA20 = Color(0xFFFFDB7A); // Pale yellow
  static const Color primaryA30 = Color(0xFFFFE29E); // Very pale yellow
  static const Color primaryA40 = Color(0xFFFFEAC1); // Almost white yellow
  static const Color primaryA50 = Color(0xFFFFF2DE); // Off-white yellow
  
  // Surface colors
  static const Color surfaceA0 = Color(0xFF121212);  // Very dark background
  static const Color surfaceA10 = Color(0xFF1E1E1E); // Dark background
  static const Color surfaceA20 = Color(0xFF2D2D2D); // Medium dark
  static const Color surfaceA30 = Color(0xFF3D3D3D); // Medium gray
  static const Color surfaceA40 = Color(0xFF505050); // Light gray
  static const Color surfaceA50 = Color(0xFF696969); // Very light gray
  
  // Field colors
  static const Color fieldBackground = Color(0xFFFFF8E9); // Cream background
  static const Color fieldBorder = Color(0xFF787878);    // Gray border
  
  // Score colors
  static const Color scoreBackground = Color(0xFFFFE384); // Yellow score highlight
  
  // Scoreboard background (pure black for OLED screens)
  static const Color scoreboardBackground = Colors.black;
  
  // Main theme colors
  static const Color primaryColor = surfaceA0;       // Background color
  static const Color secondaryColor = primaryA0;     // Accent color
  static const Color textColorDark = surfaceA0;      // Text on light backgrounds
  static const Color textColorLight = primaryA50;    // Text on dark backgrounds
  
  // Text styles
  static final TextStyle scoreTextStyle = GoogleFonts.notoSansArabic(
    textStyle: const TextStyle(
      color: primaryA0,
      fontSize: 50,
      fontWeight: FontWeight.bold,
    ),
  );
  
  static TextStyle headerTextStyle = GoogleFonts.notoSansArabic(
    textStyle: const TextStyle(
      color: primaryA0,
      fontSize: 18,
      fontWeight: FontWeight.normal,
    ),
  );
  
  static TextStyle roundTextStyle = GoogleFonts.notoSansArabic(
    textStyle: const TextStyle(
      color: surfaceA0,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
  );
  
  static TextStyle historyTextStyle = GoogleFonts.notoSansArabic(
    textStyle: const TextStyle(
      fontSize: 20,
      color: surfaceA20,
    ),
  );
  
  static TextStyle totalScoreTextStyle = GoogleFonts.notoSansArabic(
    textStyle: const TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: surfaceA0,
    ),
  );
  
  static TextStyle buttonTextStyle = GoogleFonts.notoSansArabic(
    textStyle: const TextStyle(
      color: primaryA0,
      fontSize: 22,
      fontWeight: FontWeight.bold,
    ),
  );
  
  static TextStyle bottomTextStyle = GoogleFonts.notoSansArabic(
    textStyle: const TextStyle(
      color: surfaceA20,
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
  );
  
  // ThemeData
  static ThemeData get themeData {
    return ThemeData(
      primaryColor: primaryColor,
      scaffoldBackgroundColor: primaryColor,
      textTheme: GoogleFonts.notoSansArabicTextTheme(
        const TextTheme(
          bodyLarge: TextStyle(color: textColorDark),
          bodyMedium: TextStyle(color: textColorDark),
        ),
      ),
      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: primaryColor,
        secondary: secondaryColor,
      ),
    );
  }
} 