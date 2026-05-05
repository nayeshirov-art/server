import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primary = Color(0xFF1B5E20);
  static const Color primaryLight = Color(0xFF4CAF50);
  static const Color gold = Color(0xFFD4AF37);
  static const Color background = Color(0xFF071209);
  static const Color surface = Color(0xFF0F2411);
  static const Color surfaceCard = Color(0xFF152B17);
  static const Color textPrimary = Color(0xFFF5F5F5);
  static const Color textSecondary = Color(0xFF90A4AE);

  static ThemeData get dark {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(
        primary: primary,
        secondary: gold,
        surface: surface,
        onPrimary: Colors.white,
        onSecondary: Colors.black,
      ),
      scaffoldBackgroundColor: background,
      textTheme: GoogleFonts.amiriTextTheme(
        ThemeData.dark().textTheme.apply(
              bodyColor: textPrimary,
              displayColor: textPrimary,
            ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: background,
        elevation: 0,
        centerTitle: true,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: const Color(0xFF0A1C0B),
        indicatorColor: primary.withOpacity(0.3),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: gold);
          }
          return const IconThemeData(color: Color(0xFF607D8B));
        }),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const TextStyle(
              color: gold,
              fontSize: 11,
              fontWeight: FontWeight.bold,
              fontFamily: 'Amiri',
            );
          }
          return const TextStyle(
            color: Color(0xFF607D8B),
            fontSize: 11,
            fontFamily: 'Amiri',
          );
        }),
      ),
    );
  }

  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: const ColorScheme.light(
        primary: primary,
        secondary: gold,
      ),
      textTheme: GoogleFonts.amiriTextTheme(),
    );
  }
}
