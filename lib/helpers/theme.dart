import 'package:daily_readings_admin_sdk/helpers/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  const AppTheme._();

  static ThemeData get theme {
    return ThemeData(
        scaffoldBackgroundColor: const Color(0xFF212332),
        canvasColor: const Color(0xFF2b2d3e),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primaryColor: AppColors.kPrimaryDarkenColor,
        highlightColor: Colors.white,
        brightness: Brightness.light,
        // visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: const AppBarTheme(
          color: AppColors.kPrimaryDarkenColor,
        ),
        textTheme: ThemeData.dark().textTheme,
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          // circularTrackColor: AppColors.kPrimaryColor,
          color: AppColors.kPrimaryColor,
        ),
        colorScheme:
            ColorScheme.fromSwatch().copyWith(secondary: Colors.white));
  }
}
