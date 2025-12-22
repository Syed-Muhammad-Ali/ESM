import 'package:european_single_marriage/controller/auth%20controller/on_boarding_controller.dart';
import 'package:european_single_marriage/core/common/custom_text.dart';
import 'package:european_single_marriage/core/extensions/size_box_extension.dart';
import 'package:european_single_marriage/core/utils/constant/app_colors.dart';
import 'package:european_single_marriage/core/utils/constant/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnBoardingScreen extends StatelessWidget {
  final OnBoardingController controller = Get.put(OnBoardingController());

  OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.paddingSH,
              vertical: AppSizes.paddingSV,
            ),
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: controller.pageController,
                    onPageChanged: controller.updatePage,
                    itemCount: controller.onboardingPages.length,
                    itemBuilder: (context, index) {
                      final page = controller.onboardingPages[index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppSizes.spaceBtwItems.heightBox,
                          Image.asset(page.image, height: 300),
                          AppSizes.xxl.heightBox,
                          CustomText(
                            title: page.title,
                            fontSize: 26,
                            fontWeight: FontWeight.w500,
                          ),
                          AppSizes.sm.heightBox,
                          CustomText(
                            title: page.subtitle,
                            textAlign: TextAlign.center,
                            fontSize: 15,
                            color: AppColors.subTitleColors,
                            fontWeight: FontWeight.w400,
                          ),
                        ],
                      );
                    },
                  ),
                ),
                AppSizes.spaceBtwItems.heightBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    controller.onboardingPages.length,
                    (index) => AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      width: controller.currentIndex.value == index ? 30 : 12,
                      height: controller.currentIndex.value == index ? 8 : 12,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color:
                            controller.currentIndex.value == index
                                ? AppColors.primaryColor
                                : AppColors.grey,
                        shape: BoxShape.rectangle,
                      ),
                    ),
                  ),
                ),

                30.heightBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: controller.skip,
                      child: const CustomText(
                        title: 'Skip',
                        color: AppColors.greySubtitle,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: controller.nextPage,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        minimumSize: const Size(55, 55),
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                        size: 23,
                      ),
                    ),
                  ],
                ),
                AppSizes.spaceXL.heightBox,
              ],
            ),
          ),
        );
      }),
    );
  }
}
