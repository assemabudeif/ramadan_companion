import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  // Extracted from UI/dashboard/code.html
  static const Color primary = Color(0xFF044D29); // Emerald Green
  static const Color accent = Color(0xFFD4AF37); // Gold
  static const Color background = Color(0xFFF9F7F2); // Cream
  static const Color surface = Color(0xFFFFFFFF);
  static const Color textMain = Color(0xFF1A1A1A);
}

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        primary: AppColors.primary,
        secondary: AppColors.accent,
        surface: AppColors.surface,
        background: AppColors.background,
        onSurface: AppColors.textMain,
      ),
      scaffoldBackgroundColor: AppColors.background,
      textTheme: GoogleFonts.cairoTextTheme().apply(
        bodyColor: AppColors.textMain,
        displayColor: AppColors.textMain,
      ),
      // Manrope for numbers (to be applied selectively)
      fontFamily: GoogleFonts.cairo().fontFamily,
    );
  }
}
