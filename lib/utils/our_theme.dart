import 'package:flutter/material.dart';

class OurTheme {
  final Color _lightBlue = const Color(0xFF4EB7E7);
  final Color _lightGrey = const Color(0xFFA2A5A7);
  final Color _darkerGrey = const Color(0xFF3B5774);
  final Color _darkBlue = const Color(0xFF01559A);
  ThemeData buildTheme() {
    return ThemeData(
      canvasColor: _lightBlue,
      primaryColor: _lightBlue,
      secondaryHeaderColor: _darkerGrey,
      colorScheme: ColorScheme.light(
        surface: const Color(0xFFf2f2f2),
        primary: _darkBlue,
        secondary: _lightGrey,
        tertiary: Colors.white,
      ),
      hintColor: _lightGrey,
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: _lightGrey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: _lightBlue),
        ),
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: _darkBlue,
        padding: EdgeInsets.symmetric(horizontal: 20),
        minWidth: 200,
        height: 40,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
