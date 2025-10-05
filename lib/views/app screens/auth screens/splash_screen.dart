import 'package:european_single_marriage/controller/auth%20controller/splash_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  final SpalshScreenController controller = Get.put(SpalshScreenController());
  SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset("assets/images/splash screen.png", fit: BoxFit.fill),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: SizedBox(
              height: 70,
              width: 350,
              child: Image.asset("assets/images/logo.png"),
            ),
          ),
        ],
      ),
    );
  }
}
