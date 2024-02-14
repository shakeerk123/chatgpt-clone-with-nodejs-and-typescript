
import 'package:client/app/utils/colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
      brightness: Brightness.dark,
      appBarTheme:
          AppBarTheme(backgroundColor: AppColors.scaffoldBgColor, elevation: 0),
      scaffoldBackgroundColor: AppColors.scaffoldBgColor);
}