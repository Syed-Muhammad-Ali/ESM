import 'package:european_single_marriage/core/common/custom_text.dart';
import 'package:european_single_marriage/core/utils/constant/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class MainButton extends StatelessWidget {
  final String title;
  final double width;
  final double height;
  final double? imageHeight;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final String? leftImage;
  final String? rightImage;
  final double? cir;
  final double? fontSize;
  final FontWeight? fontWeight;
  bool loading;

  MainButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.leftImage,
    this.rightImage,
    this.cir = 10,
    this.width = double.infinity,
    this.height = 50,
    this.fontSize,
    this.fontWeight,
    this.imageHeight,
    this.loading = false,
  });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? AppColors.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(cir ?? 10),
          ),
          padding: EdgeInsets.zero,
          elevation: 0,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Center(
              child:
                  loading
                      ? Center(
                        child: SleekCircularSlider(
                          appearance: CircularSliderAppearance(
                            spinnerMode: true,
                            customColors: CustomSliderColors(
                              trackColor: AppColors.grey,
                              progressBarColor: AppColors.white,
                              shadowColor: AppColors.white,
                              shadowMaxOpacity: 0.5,
                            ),
                            size: 30,
                          ),
                        ),
                      )
                      : CustomText(
                        title: title,
                        fontFamily: "Inter",
                        textAlign: TextAlign.center,
                        color: textColor ?? AppColors.white,
                        fontSize: fontSize ?? 16,
                        fontWeight: fontWeight ?? FontWeight.w500,
                      ),
            ),

            if (leftImage != null)
              Positioned(
                left: 12,
                child: Image.asset(leftImage!, height: imageHeight ?? 24),
              ),

            if (rightImage != null)
              Positioned(
                right: 12,
                child: Image.asset(rightImage!, height: imageHeight ?? 24),
              ),
          ],
        ),
      ),
    );
  }
}
