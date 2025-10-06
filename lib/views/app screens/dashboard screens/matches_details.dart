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
        matchCtrl.motherTongue.text = match.motherTongue ?? "";
        matchCtrl.eatingHabits.text = match.eatingHabits ?? "";
        matchCtrl.smokingHabits.text = match.smokingHabits ?? "";
        matchCtrl.drinkingHabits.text = match.drinkingHabits ?? "";
        matchCtrl.livesIn.text = match.isChildrenLivingWithYou ?? "";

        matchCtrl.religion.text = match.religion ?? "";
        matchCtrl.caste.text = match.caste ?? "";
        matchCtrl.subCaste.text = match.subCaste ?? "";

        matchCtrl.employment.text = match.employedIn ?? "";
        matchCtrl.annualIncome.text = match.annualIncome ?? "";

        matchCtrl.education.text = match.education ?? "";
        matchCtrl.occupation.text = match.occupation ?? "";
        matchCtrl.workLocation.text = match.workLocation ?? "";
        matchCtrl.state.text = match.state ?? "";
        matchCtrl.city.text = match.city ?? "";

        matchCtrl.maritalStatus.text = match.maritalStatus ?? "";
        matchCtrl.noOfChildren.text = match.numberOfChildren ?? "";
        matchCtrl.height.text = match.height ?? "";
        matchCtrl.familyType.text = match.familyType ?? "";
        matchCtrl.familyStatus.text = match.familyStatus ?? "";
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
                    // AppSizes.sm.widthBox,
                    // const CircleAvatar(
                    //   backgroundColor: AppColors.white,
                    //   child: Icon(
                    //     Icons.favorite_border,
                    //     color: Color(0xFFCFCFCF),
                    //   ),
                    // ),
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
                      title: match.aboutYourself ?? "No description",
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
                      readOnly: true,
                    ),
                    CustomTextField(
                      title: "Age",
                      controller: matchCtrl.age,
                      filled: true,
                      readOnly: true,
                    ),
                    CustomTextField(
                      title: "Mother Tongue",
                      controller: matchCtrl.motherTongue,
                      filled: true,
                      readOnly: true,
                    ),
                    CustomTextField(
                      title: "Eating Habits",
                      controller: matchCtrl.eatingHabits,
                      filled: true,
                      readOnly: true,
                    ),
                    CustomTextField(
                      title: "Smoking Habits",
                      controller: matchCtrl.smokingHabits,
                      filled: true,
                      readOnly: true,
                    ),
                    CustomTextField(
                      title: "Drinking Habits",
                      controller: matchCtrl.drinkingHabits,
                      filled: true,
                      readOnly: true,
                    ),

                    CustomTextField(
                      title: "Children Lives In",
                      controller: matchCtrl.livesIn,
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
                      readOnly: true,
                    ),
                    CustomTextField(
                      title: "Caste",
                      controller: matchCtrl.caste,
                      filled: true,
                      readOnly: true,
                    ),
                    CustomTextField(
                      title: "Sub Caste",
                      controller: matchCtrl.subCaste,
                      filled: true,
                      readOnly: true,
                    ),

                    // CustomTextField(
                    //   title: "Dosham",
                    //   controller: matchCtrl.dosham,
                    //   filled: true,
                    // ),
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
                      readOnly: true,
                    ),
                    CustomTextField(
                      title: "Annual Income",
                      controller: matchCtrl.annualIncome,
                      filled: true,
                      readOnly: true,
                    ),

                    AppSizes.spaceBtwItems.heightBox,
                    CustomText(
                      title: "Educational Details:",
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                    CustomTextField(
                      title: "Highest Education:",
                      controller: matchCtrl.education,
                      filled: true,
                      readOnly: true,
                    ),
                    CustomTextField(
                      title: "Occupation",
                      controller: matchCtrl.occupation,
                      filled: true,
                      readOnly: true,
                    ),
                    CustomTextField(
                      title: "Work Location",
                      controller: matchCtrl.workLocation,
                      filled: true,
                      readOnly: true,
                    ),
                    CustomTextField(
                      title: "State",
                      controller: matchCtrl.state,
                      filled: true,
                      readOnly: true,
                    ),
                    CustomTextField(
                      title: "City",
                      controller: matchCtrl.city,
                      filled: true,
                      readOnly: true,
                    ),

                    AppSizes.spaceBtwSections.heightBox,

                    // Family
                    CustomText(
                      title: "Family Details:",
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                    CustomTextField(
                      title: "Marital Status",
                      controller: matchCtrl.maritalStatus,
                      filled: true,
                      readOnly: true,
                    ),
                    CustomTextField(
                      title: "No. of  Children",
                      controller: matchCtrl.noOfChildren,
                      filled: true,
                      readOnly: true,
                    ),
                    CustomTextField(
                      title: "Height",
                      controller: matchCtrl.height,
                      filled: true,
                      readOnly: true,
                    ),
                    CustomTextField(
                      title: "Family Type",
                      controller: matchCtrl.familyType,
                      filled: true,
                      readOnly: true,
                    ),
                    CustomTextField(
                      title: "Family Status",
                      controller: matchCtrl.familyStatus,
                      filled: true,
                      readOnly: true,
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
