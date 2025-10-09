import 'package:european_single_marriage/controller/home%20controller/matches_controller.dart';
import 'package:european_single_marriage/core/common/custam_container.dart';
import 'package:european_single_marriage/core/common/custom_text.dart';
import 'package:european_single_marriage/core/extensions/size_box_extension.dart';
import 'package:european_single_marriage/core/utils/constant/app_colors.dart';
import 'package:european_single_marriage/core/utils/constant/app_sizes.dart';
import 'package:european_single_marriage/views/screens%20widgets/home%20Widget/age_range_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MatchPreferencesBottomSheet extends StatelessWidget {
  final controller = Get.put(MatchesController());
  final int initialTabIndex;

  MatchPreferencesBottomSheet({super.key, required this.initialTabIndex});

  @override
  Widget build(BuildContext context) {
    controller.selectTab(initialTabIndex);
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
                        return basicDetails();
                      case 1:
                        return regionDetails();
                      case 2:
                        return professionalDetails();
                      case 3:
                        return locationDetails();
                      case 4:
                        return familyDetails();
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

  // Widget matchPreferences() {
  //   final controller = Get.find<MatchPreferencesController>();
  //   return Obx(
  //     () => ListView(
  //       children:
  //           controller.matchFilters.keys.map((item) {
  //             return CheckboxListTile(
  //               activeColor: AppColors.primaryColor,
  //               title: CustomText(title: item, fontSize: 14),
  //               value: controller.matchFilters[item],
  //               onChanged: (value) => controller.toggleFilter(item, value),
  //               controlAffinity: ListTileControlAffinity.leading,
  //             );
  //           }).toList(),
  //     ),
  //   );
  // }

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
              title: "Gender",
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
            AppSizes.sm.heightBox,
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [chip("Male"), chip("Female")],
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
              children: [chip("Married"), chip("Unmarried"), chip("Divorced")],
            ),
          ],
        ),
      ),
    );
  }

  Widget regionDetails() {
    return Padding(
      padding: const EdgeInsets.only(left: 17),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppSizes.spaceBtwItems.heightBox,
            CustomText(
              title: "Gender",
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
            AppSizes.sm.heightBox,
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                chip("Islam"),
                chip("Christianity"),
                chip("Hinduism"),
                chip("Buddhism"),
                chip("Sikhism"),
                chip("Judaism"),
                chip("Bahá'í Faith"),
                chip("Jainism"),
                chip("Zoroastrianism"),
                chip("Taoism"),
                chip("Shinto"),
                chip("Confucianism"),
                chip("Agnostic"),
                chip("Atheist"),
                chip("Spiritual but not religious"),
                chip("Paganism"),
                chip("Animism"),
                chip("Druidism"),
                chip("Rastafarianism"),
                chip("Unitarian Universalism"),
                chip("Prefer not to say"),
                chip("Other"),
              ],
            ),
            AppSizes.spaceBtwItems.heightBox,
            CustomText(
              title: "No.Of Children",
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
            AppSizes.sm.heightBox,
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                chip('0'),
                chip('1'),
                chip('2'),
                chip('3'),
                chip('4'),
                chip('5'),
              ],
            ),
            AppSizes.spaceBtwItems.heightBox,
            CustomText(
              title: "Is Children living with you?",
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
            AppSizes.sm.heightBox,
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [chip('Yes'), chip('No')],
            ),
          ],
        ),
      ),
    );
  }

  Widget professionalDetails() {
    return Padding(
      padding: const EdgeInsets.only(left: 17),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppSizes.spaceBtwItems.heightBox,
            CustomText(
              title: "Highest Education:",
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
            AppSizes.sm.heightBox,
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                chip('Primary'),
                chip('Middle'),
                chip('Matric'),
                chip('Inter'),
                chip('Bachelor’s'),
                chip('Master’s'),
                chip('M.Phil'),
                chip('Ph.D.'),
                chip('Diploma'),
                chip('Other'),
              ],
            ),
            AppSizes.spaceBtwItems.heightBox,
            CustomText(
              title: "Employed In:",
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
            AppSizes.sm.heightBox,
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                chip('Government'),
                chip('Private Sector'),
                chip('Self-employed'),
                chip('Business Owner'),
                chip('Non-profit / NGO'),
                chip('Freelancer'),
                chip('Student'),
                chip('Retired'),
                chip('Unemployed'),
                chip('Other'),
              ],
            ),
            AppSizes.spaceBtwItems.heightBox,
            CustomText(
              title: "Occupation",
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
            AppSizes.sm.heightBox,
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                chip('Student'),
                chip('Teacher'),
                chip('Engineer'),
                chip('Doctor'),
                chip('Nurse'),
                chip('Software Developer'),
                chip('Graphic Designer'),
                chip('Content Writer'),
                chip('Lecturer'),
                chip('Fashion Designer'),
                chip('Beautician'),
                chip('Receptionist'),
                chip('HR Manager'),
                chip('Banker'),
                chip('Air Hostess'),
                chip('Businessman'),
                chip('Businesswoman'),
                chip('Freelancer'),
                chip('Government Employee'),
                chip('Private Employee'),
                chip('Police Officer'),
                chip('Army Officer'),
                chip('Driver'),
                chip('Shopkeeper'),
                chip('Farmer'),
                chip('Laborer'),
                chip('Housewife'),
                chip('Unemployed'),
                chip('Other'),
              ],
            ),
            AppSizes.spaceBtwItems.heightBox,
            CustomText(
              title: "Annual Income",
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
            AppSizes.sm.heightBox,
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                chip('Less than 1 Lakh'),
                chip('1 - 3 Lakh'),
                chip('3 - 5 Lakh'),
                chip('5 - 10 Lakh'),
                chip('10 - 20 Lakh'),
                chip('20+ Lakh'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget locationDetails() {
    return Padding(
      padding: const EdgeInsets.only(left: 17),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            AppSizes.spaceBtwItems.heightBox,
            CustomText(
              title: "Work Location",
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
            AppSizes.sm.heightBox,
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [chip('Remote'), chip('On-site'), chip('Hybrid')],
            ),
            AppSizes.spaceBtwItems.heightBox,
          ],
        ),
      ),
    );
  }

  Widget familyDetails() {
    return Padding(
      padding: const EdgeInsets.only(left: 17),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppSizes.spaceBtwItems.heightBox,
            CustomText(
              title: "Family Status",
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
            AppSizes.sm.heightBox,
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                chip('Middle Class'),
                chip('Upper Class'),
                chip('Rich'),
                chip('Normal'),
              ],
            ),
            AppSizes.spaceBtwItems.heightBox,
            CustomText(
              title: "Family Type",
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
            AppSizes.sm.heightBox,
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [chip('Joint'), chip('Nuclear')],
            ),
            AppSizes.spaceBtwItems.heightBox,
            CustomText(
              title: "Family Values",
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
            AppSizes.sm.heightBox,
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                chip('1'),
                chip('2'),
                chip('3'),
                chip('4'),
                chip('5'),
                chip('6'),
                chip('7'),
                chip('8'),
                chip('9'),
                chip('10'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget chip(String label) {
    final MatchesController controller = Get.find();
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
