import 'package:european_single_marriage/core/common/custom_text.dart';
import 'package:european_single_marriage/core/extensions/size_box_extension.dart';
import 'package:european_single_marriage/core/utils/constant/app_colors.dart';
import 'package:european_single_marriage/core/utils/constant/app_sizes.dart';
import 'package:flutter/material.dart';

class StepIndicator extends StatelessWidget {
  final int step;
  final String title;
  final String subtitle;
  final String? backStep;

  const StepIndicator({
    super.key,
    required this.step,
    required this.title,
    required this.subtitle,
    this.backStep,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 80,
              height: 80,
              child: CircularProgressIndicator(
                backgroundColor: AppColors.grey,
                value: step / 5,
                strokeWidth: 3,
                color: AppColors.primaryColor,
              ),
            ),
            CustomText(
              title: '$step of 5',
              fontSize: 18,
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
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.primaryColor,
              ),
            CustomText(title: title, fontSize: 25, fontWeight: FontWeight.w500),
            CustomText(title: subtitle, color: AppColors.gray2),
          ],
        ),
      ],
    );
  }
}
