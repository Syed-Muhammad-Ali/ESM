import 'package:european_single_marriage/controller/home%20controller/dashboard_controller.dart';
import 'package:european_single_marriage/core/utils/constant/app_colors.dart';
import 'package:european_single_marriage/views/app%20screens/dashboard%20screens/chat_screen.dart';
import 'package:european_single_marriage/views/app%20screens/dashboard%20screens/home_screen.dart';
import 'package:european_single_marriage/views/app%20screens/dashboard%20screens/matches_screen.dart';
import 'package:european_single_marriage/views/app%20screens/dashboard%20screens/profile_screen.dart';
import 'package:european_single_marriage/views/screens%20widgets/home%20Widget/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardScreen extends StatelessWidget {
  final DashboardController controller = Get.put(DashboardController());

  final screens = [
    HomeScreen(),
    MatchesScreen(),
    ChatScreen(),
    ProfileScreen(),
  ];

  DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.offWhite,
      body: Obx(() => screens[controller.selectedIndex.value]),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
