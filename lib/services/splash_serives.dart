// ignore_for_file: avoid_print

import 'dart:async';

import 'package:european_single_marriage/data/storage/app_storage.dart';
import 'package:european_single_marriage/routes/app_routes.dart';
import 'package:get/get.dart';

class SplashServices {
  void isLogin() async {
    final email = await AppStorage.get('email');
    print("Splash email : $email");
    Timer(const Duration(seconds: 1), () {
      if (email != null && email.toString().isNotEmpty) {
        Get.offAllNamed(AppRoutes.dashboardScreen);
        // Get.offAllNamed(RouteName.bnbPage);
      } else {
        Get.offAllNamed(AppRoutes.loginScreen);
      }
    });
  }
}
