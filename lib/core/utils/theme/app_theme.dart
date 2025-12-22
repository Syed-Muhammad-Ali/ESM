import 'package:european_single_marriage/core/utils/constant/app_colors.dart';
import 'package:flutter/material.dart';

class MAppTheme {
  MAppTheme._();
  static ThemeData myTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Inter',
    brightness: Brightness.light,
    primaryColor: AppColors.primaryColor,
    scaffoldBackgroundColor: AppColors.white,
  );
}
