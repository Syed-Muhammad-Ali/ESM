import 'package:european_single_marriage/controller/home%20controller/match_preferences_controller%20.dart';
import 'package:european_single_marriage/core/common/custom_text.dart';
import 'package:european_single_marriage/core/utils/constant/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget ageRangeSlider() {
  final controller = Get.find<MatchPreferencesController>();

  return Obx(
    () => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 21),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                title: controller.ageRange.value.start.round().toString(),
                fontSize: 14,
              ),
              CustomText(
                title: controller.ageRange.value.end.round().toString(),
                fontSize: 14,
              ),
            ],
          ),
        ),
        RangeSlider(
          values: controller.ageRange.value,
          min: 18,
          max: 60,
          activeColor: AppColors.primaryColor,
          inactiveColor: Colors.grey.shade300,
          divisions: 42,
          onChanged: (RangeValues values) => controller.updateAgeRange(values),
        ),
      ],
    ),
  );
}
