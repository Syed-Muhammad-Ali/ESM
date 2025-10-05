import 'package:european_single_marriage/controller/home%20controller/dashboard_controller.dart';
import 'package:european_single_marriage/core/common/custom_text.dart';
import 'package:european_single_marriage/core/utils/constant/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavBar extends StatelessWidget {
  BottomNavBar({super.key});

  final controller = Get.find<DashboardController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              boxShadow: [
                BoxShadow(
                  color: const Color(0x40B9B9B9),
                  spreadRadius: 2,
                  blurRadius: 4,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            height: 83,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildNavItem("assets/images/home.png", 'Home', 0),
                buildNavItem("assets/images/matches.png", 'Matches', 1),
                buildNavItem("assets/images/chat.png", 'Chat', 2),
                buildNavItem("assets/images/profile.png", 'Profile', 3),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildNavItem(String icon, String title, int index) {
    final bool isSelected = controller.selectedIndex.value == index;
    final Color iconColor =
        isSelected ? const Color(0xFFFFB634) : const Color(0xFF9C9C9C);

    return Expanded(
      child: GestureDetector(
        onTap: () => controller.changeTabIndex(index),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(icon, color: iconColor, height: 24, width: 24),
            CustomText(
              title: title,
              color: iconColor,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ],
        ),
      ),
    );
  }
}
