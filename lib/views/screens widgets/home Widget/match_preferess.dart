import 'package:european_single_marriage/controller/home%20controller/match_preferences_controller%20.dart';
import 'package:european_single_marriage/core/common/custam_container.dart';
import 'package:european_single_marriage/core/common/custom_text.dart';
import 'package:european_single_marriage/core/extensions/size_box_extension.dart';
import 'package:european_single_marriage/core/utils/constant/app_colors.dart';
import 'package:european_single_marriage/core/utils/constant/app_sizes.dart';
import 'package:european_single_marriage/views/screens%20widgets/home%20Widget/age_range_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MatchPreferencesBottomSheet extends StatelessWidget {
  final controller = Get.put(MatchPreferencesController());

  MatchPreferencesBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          AppSizes.spaceBtwItems.heightBox,
          CustomContainer(
            width: 80,
            height: 10,
            color: Color(0xFFDCDCDC),
            cir: 10,
          ),
          AppSizes.spaceBtwItems.heightBox,
          Container(
            height: Get.height * 0.60,
            padding: const EdgeInsets.symmetric(vertical: AppSizes.paddingSV),
            child: Row(
              children: [
                Obx(
                  () => Container(
                    width: 130,
                    decoration: BoxDecoration(
                      border: Border(
                        right: BorderSide(color: Color(0xFFDFDFDF)),
                      ),
                    ),
                    child: ListView.builder(
                      itemCount: controller.tabs.length,
                      itemBuilder: (context, index) {
                        final isSelected =
                            controller.selectedTab.value == index;
                        final tab = controller.tabs[index];

                        return InkWell(
                          onTap: () => controller.selectTab(index),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 6,
                            ),
                            decoration: BoxDecoration(
                              border: Border(
                                left: BorderSide(
                                  color:
                                      isSelected
                                          ? AppColors.orange
                                          : Colors.transparent,
                                  width: 5,
                                ),
                              ),
                              color:
                                  isSelected
                                      ? Color(0xFFFFECDA)
                                      : Colors.transparent,
                            ),
                            child: CustomText(
                              fontSize: 15,
                              title: tab,
                              fontWeight:
                                  isSelected
                                      ? FontWeight.w500
                                      : FontWeight.w400,
                              color:
                                  isSelected
                                      ? AppColors.orange
                                      : AppColors.black,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),

                Expanded(
                  child: Obx(() {
                    switch (controller.selectedTab.value) {
                      case 0:
                        return matchPreferences();
                      case 1:
                        return basicDetails();
                      default:
                        return Center(child: Text(""));
                    }
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget matchPreferences() {
    final controller = Get.find<MatchPreferencesController>();
    return Obx(
      () => ListView(
        children:
            controller.matchFilters.keys.map((item) {
              return CheckboxListTile(
                activeColor: AppColors.primaryColor,
                title: CustomText(title: item, fontSize: 14),
                value: controller.matchFilters[item],
                onChanged: (value) => controller.toggleFilter(item, value),
                controlAffinity: ListTileControlAffinity.leading,
              );
            }).toList(),
      ),
    );
  }

  Widget basicDetails() {
    return Padding(
      padding: const EdgeInsets.only(left: 17),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomText(
              title: "Age:",
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
            ageRangeSlider(),
            AppSizes.spaceBtwItems.heightBox,
            CustomText(
              title: "Height:",
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
            AppSizes.sm.heightBox,
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                chip("4’6” – 5’2”"),
                chip("5’2” – 6’0”"),
                chip("6’6” – 7’2”"),
                chip("4’6” – 5’3”"),
                chip("6’0” – 6’6”"),
              ],
            ),
            AppSizes.spaceBtwItems.heightBox,
            CustomText(
              title: "Marital Status:",
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
            AppSizes.sm.heightBox,
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [chip("Never Married"), chip("Divorced")],
            ),
          ],
        ),
      ),
    );
  }

  Widget chip(String label) {
    final MatchPreferencesController controller = Get.find();
    return Obx(() {
      final isSelected = controller.selectedHeights.contains(label);
      return InkWell(
        onTap: () => controller.toggleSelection(label),
        child: Chip(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
            side: BorderSide(
              color: isSelected ? AppColors.primaryColor : Color(0xFFCCCCCC),
            ),
          ),
          label: CustomText(
            title: label,
            color: isSelected ? AppColors.white : AppColors.black,
            fontSize: 13,
            fontWeight: FontWeight.w400,
          ),
          backgroundColor:
              isSelected ? AppColors.primaryColor : Color(0xFFF8F8F8),
          deleteIcon:
              isSelected
                  ? Icon(Icons.highlight_remove_sharp, color: AppColors.white)
                  : null,
          onDeleted:
              isSelected ? () => controller.toggleSelection(label) : null,
        ),
      );
    });
  }
}
