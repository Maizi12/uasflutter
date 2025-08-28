import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData? lightTheme() {
    return ThemeData(
      scaffoldBackgroundColor: Colors.white,
      useMaterial3: true,
      fontFamily: 'Poppins',
    );
  }
}
