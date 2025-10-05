import 'package:european_single_marriage/core/common/custam_container.dart';
import 'package:european_single_marriage/core/common/custom_text.dart';
import 'package:european_single_marriage/core/common/main_button.dart';
import 'package:european_single_marriage/core/extensions/size_box_extension.dart';
import 'package:european_single_marriage/core/utils/constant/app_colors.dart';
import 'package:european_single_marriage/core/utils/constant/app_sizes.dart';
import 'package:flutter/material.dart';

class Membership extends StatelessWidget {
  const Membership({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.offWhite,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              // padding: const EdgeInsets.symmetric(vertical: 10),
              color: AppColors.appBarColor,
              child: SafeArea(
                child: AppBar(
                  backgroundColor: AppColors.appBarColor,
                  leading: BackButton(),
                  centerTitle: true,
                  title: const CustomText(
                    title: "Membership",

                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            AppSizes.spaceBtwItems.heightBox,

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.paddingSH,
                vertical: 6,
              ),
              child: Column(
                children: [
                  CustomText(
                    title: "Unlock Premium Features",
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                  AppSizes.spaceBtwItems.heightBox,
                  CustomText(
                    title:
                        "Choose a plan that suits your journey to finding a partner.",
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF4B5563),
                    textAlign: TextAlign.center,
                  ),
                  AppSizes.spaceBtwItems.heightBox,
                  CustomContainer(
                    color: AppColors.white,
                    cir: 10,
                    shadow: true,
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSizes.paddingSH,
                      vertical: AppSizes.paddingSV,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          title: "Free Tier",
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                        ),
                        AppSizes.spaceBtwItems.heightBox,
                        CustomText(
                          title: "Basic access to the platform.",
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF4B5563),
                        ),
                        AppSizes.spaceBtwItems.heightBox,
                        dotRowText(text: "Browse limited profiles"),
                        dotRowText(text: "View limited profile details"),
                        dotRowText(text: "Send limited interests"),
                        AppSizes.spaceBtwSections.heightBox,
                        MainButton(
                          title: "Current Plan",
                          onPressed: () {},
                          backgroundColor: AppColors.perrotColor,
                        ),
                      ],
                    ),
                  ),
                  AppSizes.spaceBtwItems.heightBox,
                  CustomContainer(
                    color: AppColors.white,
                    borders: true,
                    borderCol: AppColors.purple,
                    cir: 10,
                    shadow: true,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 13,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.purple,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(8),
                                bottomLeft: Radius.circular(8),
                              ),
                            ),
                            child: CustomText(
                              title: "BEST VALUE",
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: AppSizes.paddingSH,
                            vertical: AppSizes.paddingSV,
                          ),

                          child: Column(
                            children: [
                              CustomText(
                                title: "Premium Tier",
                                fontSize: 25,
                                fontWeight: FontWeight.w700,
                                color: AppColors.purple,
                              ),
                              AppSizes.spaceBtwItems.heightBox,
                              CustomText(
                                title: "Enhanced features for serious seekers.",
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF4B5563),
                              ),
                              AppSizes.spaceBtwItems.heightBox,
                              dotRowText(text: "Full messaging access"),
                              dotRowText(text: "Profile visibility boost"),
                              dotRowText(text: "Priority listing in search"),
                              dotRowText(text: "See who viewed your profile"),
                              AppSizes.spaceBtwSections.heightBox,
                              MainButton(
                                title: "Upgrade Now",
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  AppSizes.spaceBtwItems.heightBox,

                  CustomText(
                    title: "Subscription Options",
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                  AppSizes.spaceBtwItems.heightBox,
                  subscriptionButton(title: "1 Month Plan", price: "19,99"),
                  subscriptionButton(
                    title: "3 Month Plan",
                    price: "17,99",
                    save: "(Save 10%)",
                  ),
                  subscriptionButton(
                    title: "6 Month Plan",
                    price: "14,99",
                    save: "(Save 25%)",
                  ),
                ],
              ),
            ),
            AppSizes.spaceBtwItems.heightBox,
            CustomText(
              title: "Payment Methods",
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
            AppSizes.spaceBtwSections.heightBox,
            Image.asset(
              "assets/images/paymentMethod.png",
              height: 40,
              width: 300,
            ),
            AppSizes.spaceBtwSections.heightBox,
          ],
        ),
      ),
    );
  }

  Widget dotRowText({required String text}) {
    return Column(
      children: [
        Row(
          children: [
            CircleAvatar(radius: 2, backgroundColor: AppColors.black),
            AppSizes.spaceBtwItems.widthBox,
            CustomText(
              title: text,
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Color(0xFF374151),
            ),
            AppSizes.spaceBtwSections.heightBox,
          ],
        ),
      ],
    );
  }

  Widget subscriptionButton({
    required String title,
    required String price,
    String? save,
  }) {
    return CustomContainer(
      color: AppColors.white,
      padding: EdgeInsets.all(12),
      cir: 10,
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                title: title,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              AppSizes.xs.heightBox,
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomText(
                    title: "\$$price / month",
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFf4B5563),
                  ),
                  if (save != null)
                    CustomText(
                      title: save,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFf4B5563),
                    ),
                ],
              ),
            ],
          ),
          MainButton(
            width: 81,
            height: 41,
            title: "Select",
            onPressed: () {},
            fontSize: 14,
            backgroundColor: Color(0x1AAD057F),
            cir: 100,
            textColor: AppColors.purple,
          ),
        ],
      ),
    );
  }
}
