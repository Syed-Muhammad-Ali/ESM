
import 'package:european_single_marriage/core/common/custom_text.dart';
import 'package:european_single_marriage/core/extensions/size_box_extension.dart';
import 'package:european_single_marriage/core/utils/constant/app_colors.dart';
import 'package:european_single_marriage/core/utils/constant/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomTextField extends StatelessWidget {
  final String title;
  final String hintText;
  final Color? hintcolor;
  final Color? iconcolor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? textColor;
  final TextEditingController? controller;
  final RxBool? obscureText;
  final TextInputType keyboardType;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final double borderRadius;
  final TextAlign textAlign;
  final int? maxLength;
  final bool filled;
   String? Function(String?)? validator;

   CustomTextField({
    super.key,
    required this.title,
    this.hintText = '',
    this.hintcolor,
    this.iconcolor,
    this.fontSize,
    this.fontWeight,
    this.textColor,
    this.controller,
    this.obscureText,
    this.keyboardType = TextInputType.text,
    this.prefixIcon,
    this.suffixIcon,
    this.onChanged,
    this.onSubmitted,
    this.borderColor,
    this.focusedBorderColor,
    this.borderRadius = 8.0,
    this.textAlign = TextAlign.start,
    this.maxLength,
    this.filled = false,
      this.validator,
  });

  @override
  Widget build(BuildContext context) {
    Widget textFieldWidget({required bool isObscured}) {
      return TextFormField(
        maxLength: maxLength,
        textAlign: textAlign,
        controller: controller,
        obscureText: isObscured,
        keyboardType: keyboardType,
        onChanged: onChanged,
        // onSubmitted: onSubmitted,
        validator: validator,
        style: TextStyle(
          fontSize: fontSize ?? 16.0,
          fontWeight: fontWeight ?? FontWeight.normal,
          color: textColor ?? Colors.black,
        ),
        decoration: InputDecoration(
          filled: filled,
          fillColor: filled ? const Color(0xFFFCFCFD) : null,
          counterText: "",
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 2,
          ),
          hintText: hintText,
          hintStyle: TextStyle(color: hintcolor ?? Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: AppColors.borderCol),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: AppColors.borderCol),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: AppColors.borderCol),
          ),
          prefixIcon:
              prefixIcon != null
                  ? Icon(prefixIcon, color: iconcolor ?? Colors.grey)
                  : null,
          suffixIcon:
              obscureText != null
                  ? IconButton(
                    icon: Icon(
                      isObscured ? Icons.visibility : Icons.visibility_off,
                      color: iconcolor ?? Colors.grey,
                    ),
                    onPressed: () {
                      obscureText!.value = !obscureText!.value;
                    },
                  )
                  : (suffixIcon != null
                      ? Icon(suffixIcon, color: iconcolor ?? Colors.grey)
                      : null),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          title: title,
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: AppColors.gray1,
        ),
        const SizedBox(height: 5),
        obscureText != null
            ? Obx(() => textFieldWidget(isObscured: obscureText!.value))
            : textFieldWidget(isObscured: false),
        AppSizes.spaceBtwItems.heightBox,
      ],
    );
  }
}
