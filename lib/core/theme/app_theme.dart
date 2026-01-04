import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  // Extracted from UI/dashboard/code.html & screen.png
  static const Color primary = Color(0xFF044D29); // Emerald Green
  static const Color primaryDark = Color(0xFF02361D); // Darker Green for cards
  static const Color accent = Color(0xFFD4AF37); // Gold
  static const Color accentLight = Color(0xFFE5C158); // Lighter Gold
  static const Color background = Color(0xFFF9F7F2); // Cream
  static const Color surface = Color(0xFFFFFFFF);
  static const Color textMain = Color(0xFF1A1A1A);
  static const Color textLight = Color(0xFFFFFFFF);
  static const Color textMuted = Color(0xFF666666);
  static const Color highlight = Color(0xFF044D29);
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
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.primary),
        titleTextStyle: TextStyle(
          color: AppColors.primary,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      textTheme: GoogleFonts.cairoTextTheme().apply(
        bodyColor: AppColors.textMain,
        displayColor: AppColors.textMain,
      ),
      // Set default font
      fontFamily: GoogleFonts.cairo().fontFamily,
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: Brightness.dark,
        primary: AppColors.primary,
        secondary: AppColors.accent,
        surface: const Color(0xFF1E1E1E),
        background: const Color(0xFF121212),
        onSurface: Colors.white,
      ),
      scaffoldBackgroundColor: const Color(0xFF121212),
      textTheme: GoogleFonts.cairoTextTheme(
        ThemeData.dark().textTheme,
      ).apply(bodyColor: Colors.white, displayColor: Colors.white),
      fontFamily: GoogleFonts.cairo().fontFamily,
    );
  }
}
