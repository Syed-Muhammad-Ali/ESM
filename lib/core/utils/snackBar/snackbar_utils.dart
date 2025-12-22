import 'package:european_single_marriage/core/utils/constant/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Utils {
  static snackBar(String title, String message, Color backgroundColor) {
    Get.snackbar(
      title,
      message,
      backgroundColor: backgroundColor,
      colorText: AppColors.white,
    );
  }
}
