import 'package:european_single_marriage/core/common/custam_container.dart';
import 'package:european_single_marriage/core/common/custom_text.dart';
import 'package:european_single_marriage/core/extensions/size_box_extension.dart';
import 'package:european_single_marriage/core/utils/constant/app_colors.dart';
import 'package:european_single_marriage/core/utils/constant/app_sizes.dart';
import 'package:flutter/material.dart';

class CustomDropdown extends StatelessWidget {
  final String hint;
  final List<String> items;
  final String value;
  final String title;
  final Color? color;
  final bool borders;
  final Color? borderCol;
  final Function(String?) onChanged;

  const CustomDropdown({
    required this.hint,
    required this.items,
    this.color,
    this.borders = true,
    this.borderCol,
    required this.title,
    required this.value,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          title: title,
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: AppColors.gray1,
        ),
        CustomContainer(
          padding: EdgeInsets.symmetric(horizontal: 8),
          color: color,
          borders: borders,
          borderCol: borderCol ?? AppColors.borderCol,
          cir: 10,

          child: DropdownButtonFormField<String>(
            dropdownColor: AppColors.white,
            decoration: InputDecoration(border: InputBorder.none),
            icon: Icon(Icons.keyboard_arrow_down_sharp, color: AppColors.gray1),
            value: value.isEmpty ? null : value,
            hint: CustomText(title: hint, fontSize: 15),
            items:
                items
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
            onChanged: onChanged,
          ),
        ),
        AppSizes.spaceBtwItems.heightBox,
      ],
    );
  }
}
