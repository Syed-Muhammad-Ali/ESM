import 'package:european_single_marriage/controller/home%20controller/matches_controller.dart';
import 'package:european_single_marriage/core/common/custom_text.dart';
import 'package:european_single_marriage/core/common/custom_textfield.dart';
import 'package:european_single_marriage/core/extensions/size_box_extension.dart';
import 'package:european_single_marriage/core/utils/constant/app_colors.dart';
import 'package:european_single_marriage/core/utils/constant/app_sizes.dart';
import 'package:european_single_marriage/views/screens%20widgets/home%20Widget/match_card.dart';
import 'package:european_single_marriage/views/screens%20widgets/home%20Widget/search_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MatchesDetails extends StatelessWidget {
  final matchCtrl = Get.find<MatchesController>();

  MatchesDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        final match = matchCtrl.matchDetails.value;
        if (match == null) {
          return const Center(child: Text("No match selected"));
        }

        // Populate controllers with data (so fields show details)
        matchCtrl.dob.text = match.dob ?? "";
        matchCtrl.age.text = match.age?.toString() ?? "";
        // matchCtrl.motherTongue.text = match.motherTongue ?? "";
        // matchCtrl.eatingHabits.text = match.eatingHabits ?? "";
        // matchCtrl.smokingHabits.text = match.smokingHabits ?? "";
        // matchCtrl.drinkingHabits.text = match.drinkingHabits ?? "";
        // matchCtrl.profileCreatedBy.text = match.profileCreatedBy ?? "";
        // matchCtrl.maritalStatus.text = match.maritalStatus ?? "";
        // matchCtrl.livesIn.text = match.city ?? "";
        // matchCtrl.citizen.text = match.citizen ?? "";

        // matchCtrl.religion.text = match.religion ?? "";
        // matchCtrl.caste.text = match.caste ?? "";
        // matchCtrl.gothram.text = match.gothram ?? "";
        // matchCtrl.dosham.text = match.dosham ?? "";

        // matchCtrl.employment.text = match.occupation ?? "";
        // matchCtrl.degree.text = match.education ?? "";
        // matchCtrl.university.text = match.university ?? "";

        // matchCtrl.familyType.text = match.familyType ?? "";
        // matchCtrl.parents.text = match.parents ?? "";
        // matchCtrl.ancestralOrigin.text = match.ancestralOrigin ?? "";

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(left: 12, right: 12, top: 30),
                width: double.infinity,
                color: AppColors.appBarColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const BackButton(),
                    const Expanded(flex: 4, child: SearchField()),
                    AppSizes.sm.widthBox,
                    const CircleAvatar(
                      backgroundColor: AppColors.white,
                      child: Icon(
                        Icons.favorite_border,
                        color: Color(0xFFCFCFCF),
                      ),
                    ),
                  ],
                ),
              ),
              AppSizes.sm.heightBox,
              MatchCard(match: match),

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.paddingSH,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      title: "About her:",
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                    AppSizes.sm.heightBox,
                    CustomText(
                      title: "No description",
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF6D6D6D),
                    ),
                    AppSizes.spaceBtwSections.heightBox,

                    // Basic Details
                    CustomText(
                      title: "Basic Details:",
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                    AppSizes.spaceBtwItems.heightBox,
                    CustomTextField(
                      title: "D.O.B",
                      controller: matchCtrl.dob,
                      filled: true,
                    ),
                    CustomTextField(
                      title: "Age",
                      controller: matchCtrl.age,
                      filled: true,
                    ),
                    CustomTextField(
                      title: "Mother Tongue",
                      controller: matchCtrl.motherTongue,
                      filled: true,
                    ),
                    CustomTextField(
                      title: "Eating Habits",
                      controller: matchCtrl.eatingHabits,
                      filled: true,
                    ),
                    CustomTextField(
                      title: "Smoking Habits",
                      controller: matchCtrl.smokingHabits,
                      filled: true,
                    ),
                    CustomTextField(
                      title: "Drinking Habits",
                      controller: matchCtrl.drinkingHabits,
                      filled: true,
                    ),
                    CustomTextField(
                      title: "Profile Created By",
                      controller: matchCtrl.profileCreatedBy,
                      filled: true,
                    ),
                    CustomTextField(
                      title: "Marital Status",
                      controller: matchCtrl.maritalStatus,
                      filled: true,
                    ),
                    CustomTextField(
                      title: "Lives In",
                      controller: matchCtrl.livesIn,
                      filled: true,
                    ),
                    CustomTextField(
                      title: "Citizen",
                      controller: matchCtrl.citizen,
                      filled: true,
                    ),

                    AppSizes.spaceBtwSections.heightBox,

                    // Religion
                    CustomText(
                      title: "Religion Details:",
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                    CustomTextField(
                      title: "Religion",
                      controller: matchCtrl.religion,
                      filled: true,
                    ),
                    CustomTextField(
                      title: "Caste",
                      controller: matchCtrl.caste,
                      filled: true,
                    ),
                    CustomTextField(
                      title: "Gothram",
                      controller: matchCtrl.gothram,
                      filled: true,
                    ),
                    CustomTextField(
                      title: "Dosham",
                      controller: matchCtrl.dosham,
                      filled: true,
                    ),

                    AppSizes.spaceBtwSections.heightBox,

                    // Professional + Education
                    CustomText(
                      title: "Professional Details:",
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                    CustomTextField(
                      title: "Employment",
                      controller: matchCtrl.employment,
                      filled: true,
                    ),

                    AppSizes.spaceBtwItems.heightBox,
                    CustomText(
                      title: "Educational Details:",
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                    CustomTextField(
                      title: "Degree",
                      controller: matchCtrl.degree,
                      filled: true,
                    ),
                    CustomTextField(
                      title: "University",
                      controller: matchCtrl.university,
                      filled: true,
                    ),

                    AppSizes.spaceBtwSections.heightBox,

                    // Family
                    CustomText(
                      title: "Family Details:",
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                    CustomTextField(
                      title: "Family Type",
                      controller: matchCtrl.familyType,
                      filled: true,
                    ),
                    CustomTextField(
                      title: "Parents",
                      controller: matchCtrl.parents,
                      filled: true,
                    ),
                    CustomTextField(
                      title: "Ancestral Origin",
                      controller: matchCtrl.ancestralOrigin,
                      filled: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
