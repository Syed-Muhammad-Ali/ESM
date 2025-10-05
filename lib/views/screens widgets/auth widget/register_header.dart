import 'package:european_single_marriage/core/common/custom_text.dart';
import 'package:european_single_marriage/core/extensions/size_box_extension.dart';
import 'package:european_single_marriage/core/utils/constant/app_colors.dart';
import 'package:european_single_marriage/core/utils/constant/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterHeader extends StatelessWidget {
  final int step;
  final String title;
  final String? subtitle;
  final String? backStep;
  final String heading;
  const RegisterHeader({
    super.key,
    required this.step,
    required this.title,
    this.subtitle,
    this.backStep,
    required this.heading,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppSizes.spaceBtwItems.heightBox,
        BackButton().paddingOnly(left: 10),
        Padding(
          padding: EdgeInsets.only(
            top: AppSizes.sm,
            bottom: AppSizes.paddingSV,
            left: AppSizes.paddingSH,
          ),
          child: Row(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 70,
                    height: 70,
                    child: CircularProgressIndicator(
                      backgroundColor: AppColors.grey,
                      value: step / 5,
                      strokeWidth: 3,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  CustomText(
                    title: '$step of 5',
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
              AppSizes.spaceMd.widthBox,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (backStep != null)
                    CustomText(
                      title: "Prev. Step: $backStep",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryColor,
                    ),
                  CustomText(
                    title: title,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                  if (subtitle != null)
                    CustomText(
                      title: subtitle!,
                      color: AppColors.gray2,
                      fontSize: 14,
                    ),
                ],
              ),
            ],
          ),
        ),

        Container(
          height: 1,
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.white,
            boxShadow: [
              BoxShadow(
                color: Color(0x40B9B9B9),
                spreadRadius: 2,
                blurRadius: 4,
                offset: Offset(0, 4),
              ),
            ],
          ),
        ),
        AppSizes.spaceMd.heightBox,

        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.paddingSH,
            vertical: AppSizes.sm,
          ),
          child: CustomText(
            title: heading,
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: AppColors.titleColor2,
          ),
        ),

        AppSizes.spaceMd.heightBox,
      ],
    );
  }
}
