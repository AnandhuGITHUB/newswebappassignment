import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_palette.dart';

class AppTheme {
  static _border([Color color = AppPalette.greyColor]) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(
          color: color,
          width: 3.0,
        ),
      );
  static final darkThemeMode = ThemeData.dark().copyWith(
    textTheme: GoogleFonts.latoTextTheme(
      const TextTheme(
        displayLarge: TextStyle(color: Colors.white),
        displayMedium: TextStyle(color: Colors.white),
        displaySmall: TextStyle(color: Colors.white),
        headlineMedium: TextStyle(color: Colors.white),
        headlineSmall: TextStyle(color: Colors.white),
        titleLarge: TextStyle(color: Colors.white),
        titleMedium: TextStyle(color: Colors.white),
        titleSmall: TextStyle(color: Colors.white),
        bodyLarge: TextStyle(color: Colors.white),
        bodyMedium: TextStyle(color: Colors.white),
        bodySmall: TextStyle(color: Colors.white),
        labelLarge: TextStyle(color: Colors.white),
        labelSmall: TextStyle(color: Colors.white),
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppPalette.darkBackgroundColor,
      titleTextStyle: TextStyle(
        color: AppPalette.whiteColor,
        fontSize: 18,
      ),
      iconTheme: IconThemeData(
        color: AppPalette.whiteColor,
      ),
    ),
    scaffoldBackgroundColor: AppPalette.darkBackgroundColor,
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(27.0),
      focusedBorder: _border(AppPalette.gradient2),
      enabledBorder: _border(AppPalette.borderColor),
      errorBorder: _border(AppPalette.errorColor),
      border: _border(),
    ),
    dialogTheme: const DialogTheme(
      backgroundColor: AppPalette.darkBackgroundColor,
    ),
  );
  static final lightThemeMode = ThemeData.light().copyWith(
    textTheme: GoogleFonts.latoTextTheme(
      const TextTheme(
        displayLarge: TextStyle(color: Colors.black),
        displayMedium: TextStyle(color: Colors.black),
        displaySmall: TextStyle(color: Colors.black),
        headlineMedium: TextStyle(color: Colors.black),
        headlineSmall: TextStyle(color: Colors.black),
        titleLarge: TextStyle(color: Colors.black),
        titleMedium: TextStyle(color: Colors.black),
        titleSmall: TextStyle(color: Colors.black),
        bodyLarge: TextStyle(color: Colors.black),
        bodyMedium: TextStyle(color: Colors.black),
        bodySmall: TextStyle(color: Colors.black),
        labelLarge: TextStyle(color: Colors.black),
        labelSmall: TextStyle(color: Colors.black),
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppPalette.whiteBackgroundColor,
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 18,
      ),
      iconTheme: IconThemeData(color: Colors.black),
    ),
    scaffoldBackgroundColor: AppPalette.whiteBackgroundColor,
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: const TextStyle(color: Colors.black),
      contentPadding: const EdgeInsets.all(27.0),
      focusedBorder: _border(AppPalette.gradient2),
      enabledBorder: _border(AppPalette.borderColor),
      errorBorder: _border(AppPalette.errorColor),
      border: _border(),
    ),
    dialogTheme: const DialogTheme(
      backgroundColor: AppPalette.whiteBackgroundColor,
    ),
  );
}
