import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  // Dark Luxurious Theme
  static const darkBackground = Color(0xFF0A0E27);
  static const darkSurface = Color(0xFF141B3D);
  static const darkCard = Color(0xFF1A2347);
  
  // Accent Colors
  static const gold = Color(0xFFFFD700);
  static const neonBlue = Color(0xFF00D4FF);
  static const purple = Color(0xFF9D4EDD);
  static const pink = Color(0xFFFF6B9D);
  
  // Text Colors
  static const textPrimary = Color(0xFFFFFFFF);
  static const textSecondary = Color(0xFFB8C5D6);
  static const textTertiary = Color(0xFF8A96A8);
  
  // Status Colors
  static const online = Color(0xFF00FF87);
  static const offline = Color(0xFF6B7280);
  static const typing = Color(0xFF00D4FF);
  
  // Functional Colors
  static const success = Color(0xFF10B981);
  static const error = Color(0xFFEF4444);
  static const warning = Color(0xFFFBBF24);
}

ThemeData get darkTheme => ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  scaffoldBackgroundColor: AppColors.darkBackground,
  colorScheme: ColorScheme.dark(
    primary: AppColors.gold,
    secondary: AppColors.neonBlue,
    tertiary: AppColors.purple,
    surface: AppColors.darkSurface,
    error: AppColors.error,
    onPrimary: Colors.black,
    onSecondary: Colors.white,
    onSurface: AppColors.textPrimary,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.darkSurface,
    foregroundColor: AppColors.textPrimary,
    elevation: 0,
    centerTitle: true,
    titleTextStyle: GoogleFonts.cairo(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: AppColors.textPrimary,
    ),
  ),
  cardTheme: CardThemeData(
    color: AppColors.darkCard,
    elevation: 0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.gold,
      foregroundColor: Colors.black,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 0,
      textStyle: GoogleFonts.cairo(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: AppColors.textPrimary,
      side: const BorderSide(color: AppColors.gold, width: 2),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      textStyle: GoogleFonts.cairo(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: AppColors.neonBlue,
      textStyle: GoogleFonts.cairo(
        fontSize: 15,
        fontWeight: FontWeight.w600,
      ),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.darkCard,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.gold, width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.error, width: 2),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    hintStyle: GoogleFonts.cairo(
      color: AppColors.textTertiary,
      fontSize: 15,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: AppColors.darkSurface,
    selectedItemColor: AppColors.gold,
    unselectedItemColor: AppColors.textTertiary,
    type: BottomNavigationBarType.fixed,
    elevation: 0,
    selectedLabelStyle: GoogleFonts.cairo(
      fontSize: 12,
      fontWeight: FontWeight.w600,
    ),
    unselectedLabelStyle: GoogleFonts.cairo(
      fontSize: 12,
      fontWeight: FontWeight.normal,
    ),
  ),
  textTheme: TextTheme(
    displayLarge: GoogleFonts.cairo(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: AppColors.textPrimary,
    ),
    displayMedium: GoogleFonts.cairo(
      fontSize: 28,
      fontWeight: FontWeight.bold,
      color: AppColors.textPrimary,
    ),
    displaySmall: GoogleFonts.cairo(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: AppColors.textPrimary,
    ),
    headlineLarge: GoogleFonts.cairo(
      fontSize: 22,
      fontWeight: FontWeight.bold,
      color: AppColors.textPrimary,
    ),
    headlineMedium: GoogleFonts.cairo(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimary,
    ),
    headlineSmall: GoogleFonts.cairo(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimary,
    ),
    titleLarge: GoogleFonts.cairo(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimary,
    ),
    titleMedium: GoogleFonts.cairo(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimary,
    ),
    titleSmall: GoogleFonts.cairo(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimary,
    ),
    bodyLarge: GoogleFonts.cairo(
      fontSize: 16,
      fontWeight: FontWeight.normal,
      color: AppColors.textPrimary,
    ),
    bodyMedium: GoogleFonts.cairo(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      color: AppColors.textSecondary,
    ),
    bodySmall: GoogleFonts.cairo(
      fontSize: 12,
      fontWeight: FontWeight.normal,
      color: AppColors.textTertiary,
    ),
    labelLarge: GoogleFonts.cairo(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimary,
    ),
    labelMedium: GoogleFonts.cairo(
      fontSize: 12,
      fontWeight: FontWeight.w600,
      color: AppColors.textSecondary,
    ),
    labelSmall: GoogleFonts.cairo(
      fontSize: 10,
      fontWeight: FontWeight.w600,
      color: AppColors.textTertiary,
    ),
  ),
);

ThemeData get lightTheme => darkTheme;
