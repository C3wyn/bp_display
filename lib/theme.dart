import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BPTheme {
  static final ColorScheme customColorScheme = ColorScheme.dark(
      primary: Color(0xFFFFD700), // Gold color
      secondary: Color(0xFFFFA500), // Matching color (Orange)
    );

  static final _bebasFontInstance = GoogleFonts.bebasNeue();
  static final _saFontInstance = GoogleFonts.eduSaBeginner();
  static final themeData = ThemeData(
    brightness: Brightness.dark, // Dark theme
    primaryColor: customColorScheme.primary,        
    colorScheme: customColorScheme,
    textTheme: TextTheme(
      displayLarge: TextStyle(
        fontSize: 48,
        fontFamily: _bebasFontInstance.fontFamily,
        fontWeight: FontWeight.bold,
        letterSpacing: 3
      ),
      displayMedium: TextStyle(
        fontSize: 36,
        fontFamily: _bebasFontInstance.fontFamily,
        fontWeight: FontWeight.bold,
        letterSpacing: 3
      ),
      displaySmall: TextStyle(
        fontSize: 24,
        fontFamily: _bebasFontInstance.fontFamily,
        fontWeight: FontWeight.bold,
        letterSpacing: 3
      ),

      titleLarge: TextStyle(
        fontSize: 36,
        fontFamily: _bebasFontInstance.fontFamily,
        letterSpacing: 1
      ),
      titleMedium: TextStyle(
        fontSize: 24,
        fontFamily: _bebasFontInstance.fontFamily,
        letterSpacing: 3
      ),
      titleSmall: TextStyle(
        fontSize: 16,
        fontFamily: _bebasFontInstance.fontFamily,
        letterSpacing: 3
      ),
      bodyLarge: TextStyle(
        fontSize: 24,
        fontFamily: _saFontInstance.fontFamily,
      ),
      bodyMedium: TextStyle(
        fontSize: 16,
        fontFamily: _saFontInstance.fontFamily,
      ),
      bodySmall: TextStyle(
        fontSize: 10,
        fontFamily: _saFontInstance.fontFamily,
      ),
    )
  );
}