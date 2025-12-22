import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Premium Colors
  static const _primary = Color(0xFF6366F1); // Electric Indigo
  static const _secondary = Color(0xFF10B981); // Emerald
  static const _error = Color(0xFFF43F5E); // Rose
  
  // Dark Palette
  static const _darkBackground = Color(0xFF0F172A); // Deep Slate
  static const _darkSurface = Color(0xFF1E293B); // Slate
  static const _darkSurfaceHighlight = Color(0xFF334155); // Light Slate
  
  // Light Palette
  static const _lightBackground = Color(0xFFFFFFFF); // Pure White
  static const _lightSurface = Color(0xFFF8FAFC); // Slate 50
  static const _lightPrimary = Color(0xFF2563EB); // Blue 600 (Standard, accessible blue)
  static const _lightTextPrimary = Color(0xFF0F172A); // Slate 900 (High contrast)
  static const _lightTextSecondary = Color(0xFF475569); // Slate 600

  static ThemeData get light => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorScheme: const ColorScheme.light(
          primary: _lightPrimary,
          secondary: _secondary,
          surface: _lightSurface,
          error: _error,
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onSurface: _lightTextPrimary,
          onError: Colors.white,
          surfaceContainerHighest: Color(0xFFE2E8F0), // Slate 200
        ),
        scaffoldBackgroundColor: _lightBackground,
        textTheme: GoogleFonts.interTextTheme().apply(
          bodyColor: _lightTextPrimary,
          displayColor: _lightTextPrimary,
        ),
        appBarTheme: const AppBarTheme(
          centerTitle: false,
          elevation: 0,
          backgroundColor: _lightBackground,
          foregroundColor: _lightTextPrimary,
          iconTheme: IconThemeData(color: _lightTextPrimary),
          surfaceTintColor: Colors.transparent,
        ),
        cardTheme: CardThemeData(
          elevation: 0,
          color: _lightSurface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: Color(0xFFE2E8F0)), // Slate 200
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: _lightSurface,
          labelStyle: const TextStyle(color: _lightTextSecondary),
          hintStyle: const TextStyle(color: _lightTextSecondary),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: _lightPrimary, width: 2),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: _lightPrimary,
            foregroundColor: Colors.white,
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            textStyle: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );

  static ThemeData get dark => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: const ColorScheme.dark(
          primary: _primary,
          secondary: _secondary,
          surface: _darkSurface,
          error: _error,
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onSurface: Color(0xFFF8FAFC),
          onError: Colors.white,
        ),
        scaffoldBackgroundColor: _darkBackground,
        textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
        appBarTheme: const AppBarTheme(
          centerTitle: false,
          elevation: 0,
          backgroundColor: _darkBackground,
          foregroundColor: Colors.white,
        ),
        cardTheme: CardThemeData(
          elevation: 0,
          color: _darkSurface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: _darkSurfaceHighlight),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: _darkSurface,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: _darkSurfaceHighlight),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: _darkSurfaceHighlight),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: _primary, width: 2),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: _primary,
            foregroundColor: Colors.white,
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      );
}