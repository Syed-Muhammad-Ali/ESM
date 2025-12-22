import 'package:european_single_marriage/core/common/custom_text.dart';
import 'package:european_single_marriage/core/extensions/size_box_extension.dart';
import 'package:european_single_marriage/core/utils/constant/app_colors.dart';
import 'package:european_single_marriage/core/utils/constant/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomToggleSelector extends StatelessWidget {
  final String title;
  final List<String> options;
  final RxString selectedValue;
  final double height;
  final void Function(String)? onChanged;
  final double borderRadius;
  final Color selectedColor;
  final Color borderColor;

  const CustomToggleSelector({
    super.key,
    required this.title,
    required this.options,
    required this.selectedValue,
    this.onChanged,
    this.height = 40,
    this.borderRadius = 6,
    this.selectedColor = const Color(0xFFFFE9BD),
    this.borderColor = const Color(0xFFE7E7E7),
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(title: title, color: AppColors.gray1, fontSize: 15),
        Obx(() {
          return Container(
            decoration: BoxDecoration(
              border: Border.all(color: borderColor),
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            child: Row(
              children:
                  options.asMap().entries.map((entry) {
                    final index = entry.key;
                    final label = entry.value;
                    final isSelected = selectedValue.value == label;

                    BorderRadius itemRadius = BorderRadius.zero;
                    if (index == 0) {
                      itemRadius = BorderRadius.only(
                        topLeft: Radius.circular(borderRadius),
                        bottomLeft: Radius.circular(borderRadius),
                      );
                    } else if (index == options.length - 1) {
                      itemRadius = BorderRadius.only(
                        topRight: Radius.circular(borderRadius),
                        bottomRight: Radius.circular(borderRadius),
                      );
                    }

                    return Expanded(
                      child: GestureDetector(
                        onTap: () {
                          selectedValue.value = label;
                          if (onChanged != null) onChanged!(label);
                        },
                        child: Container(
                          height: height,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color:
                                isSelected ? selectedColor : Colors.transparent,
                            border: Border(
                              right:
                                  index != options.length - 1
                                      ? BorderSide(color: borderColor)
                                      : BorderSide.none,
                            ),
                            borderRadius: itemRadius,
                          ),
                          child: Text(
                            label,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
            ),
          );
        }),
        AppSizes.spaceBtwItems.heightBox,
      ],
    );
  }
}
