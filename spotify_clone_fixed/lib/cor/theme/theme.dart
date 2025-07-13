import 'package:flutter/material.dart';
import 'package:client/cor/theme/app_pallete.dart';

class AppTheme {
  static OutlineInputBorder _border(Color color, double width) =>
      OutlineInputBorder(
        borderSide: BorderSide(
          color: color,
          width: width,
        ),
        borderRadius: BorderRadius.circular(10),
      );

  static final darkThemeMode = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: Pallete.backgroundColor,
    inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.all(27),
        enabledBorder: _border(Pallete.borderColor, 1.0),
        focusedBorder: _border(Pallete.gradient2, 3.0)),
  );
}
