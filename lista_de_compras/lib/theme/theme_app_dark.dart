import 'package:flutter/material.dart';

ThemeData buildThemeData() {
  return ThemeData(
    // Define the default brightness and colors.
    brightness: Brightness.dark,
    primaryColor: Colors.deepOrange[800],
    accentColor: Colors.red[600],
    // Define the default font family.
    fontFamily: 'Georgia'
  );
}