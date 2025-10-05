import 'package:european_single_marriage/core/utils/constant/app_images.dart';
import 'package:european_single_marriage/model/on_boarding_model.dart';
import 'package:european_single_marriage/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnBoardingController extends GetxController {
  RxInt currentIndex = 0.obs;
  late PageController pageController;

  final onboardingPages =
      <OnBoardingModel>[
        OnBoardingModel(
          title: 'Create Profile',
          subtitle:
              'Lorem ipsum is placeholder text commonly used in the graphic, print, and publishing industries.',
          image: AppImages.onBoarding1,
        ),
        OnBoardingModel(
          title: 'Search for Matches',
          subtitle:
              'Lorem ipsum is placeholder text commonly used in the graphic, print, and publishing industries.',
          image: AppImages.onBoarding2,
        ),
        OnBoardingModel(
          title: 'Send Interest & Connect',
          subtitle:
              'Lorem ipsum is placeholder text commonly used in the graphic, print, and publishing industries.',
          image: AppImages.onBoarding3,
        ),
      ].obs;

  @override
  void onInit() {
    pageController = PageController();
    super.onInit();
  }

  void nextPage() {
    if (currentIndex.value < onboardingPages.length - 1) {
      currentIndex++;
      pageController.animateToPage(
        currentIndex.value,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Get.offAllNamed(AppRoutes.loginScreen);
    }
  }

  void skip() {
    currentIndex.value = onboardingPages.length - 1;
    pageController.animateToPage(
      currentIndex.value,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void updatePage(int index) {
    currentIndex.value = index;
  }
}
