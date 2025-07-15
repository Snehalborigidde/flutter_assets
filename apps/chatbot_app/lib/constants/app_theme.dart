import 'package:flutter/material.dart';

/// All App Colors
class AppColors {
  static const Color primary = Colors.indigo;
  static const Color secondary = Colors.grey;

  static const Color appBarBackground = Colors.blueAccent;
  static const Color appBarForeground = Colors.white;

  static const Color background = Colors.white;
  static const Color text = Colors.black;
  static const Color subtitle = Colors.black87;

// Add more colors if needed
}

/// App Theme (Light & Dark)
class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.background,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.appBarBackground,
      foregroundColor: AppColors.appBarForeground,
      elevation: 0,
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: AppColors.appBarForeground,
      ),
      iconTheme: IconThemeData(color: AppColors.appBarForeground),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(fontSize: 16, color: AppColors.text),
      bodyMedium: TextStyle(fontSize: 14, color: AppColors.subtitle),
    ),
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
    useMaterial3: true,
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
    ),
    useMaterial3: true,
  );
}
