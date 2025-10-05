import 'package:european_single_marriage/controller/auth%20controller/auth_controller.dart';
import 'package:european_single_marriage/core/common/custom_drop_down.dart';
import 'package:european_single_marriage/core/common/main_button.dart';
import 'package:european_single_marriage/core/extensions/media_query.dart';
import 'package:european_single_marriage/core/extensions/size_box_extension.dart';
import 'package:european_single_marriage/core/utils/constant/app_colors.dart';
import 'package:european_single_marriage/core/utils/constant/app_sizes.dart';
import 'package:european_single_marriage/core/utils/snackBar/snackbar_utils.dart';
import 'package:european_single_marriage/views/screens%20widgets/auth%20widget/register_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfessionalDetails extends StatelessWidget {
  final controller = Get.find<AuthController>();
  final _formKey = GlobalKey<FormState>();

  ProfessionalDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RegisterHeader(
                  step: 4,
                  title: "Professional Details",
                  subtitle: "Next Step: About Yourself",
                  backStep: "Personal Details",
                  heading: "Please provide your professional details:",
                ),

                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomDropdown(
                        title: "Highest Education:",
                        hint: "Select Education",
                        items: controller.educationOptions,
                        value: controller.education.value,
                        onChanged:
                            (val) => controller.education.value = val ?? '',
                      ),
                      CustomDropdown(
                        title: "Employed In:",
                        hint: "Select Employment",
                        items: controller.employedInOptions,
                        value: controller.employedIn.value,
                        onChanged:
                            (val) => controller.employedIn.value = val ?? '',
                      ),
                      CustomDropdown(
                        title: "Occupation:",
                        hint: "Select Occupation",
                        items: controller.occupationOptions,
                        value: controller.occupation.value,
                        onChanged:
                            (val) => controller.occupation.value = val ?? '',
                      ),
                      CustomDropdown(
                        title: "Annual Income (Rs):",
                        hint: "Select Annual Income",
                        items: controller.annualIncomeOptions,
                        value: controller.annualIncome.value,
                        onChanged:
                            (val) => controller.annualIncome.value = val ?? '',
                      ),
                      CustomDropdown(
                        title: "Work Location:",
                        hint: "Select Work Location",
                        items: controller.workLocationOptions,
                        value: controller.workLocation.value,
                        onChanged:
                            (val) => controller.workLocation.value = val ?? '',
                      ),
                      CustomDropdown(
                        title: "State:",
                        hint: "Select State",
                        items: controller.stateOptions,
                        value: controller.selectedState.value,
                        onChanged:
                            (val) => controller.selectedState.value = val ?? '',
                      ),
                      CustomDropdown(
                        title: "City:",
                        hint: "Select City",
                        items: controller.cityOptions,
                        value: controller.selectedCity.value,
                        onChanged:
                            (val) => controller.selectedCity.value = val ?? '',
                      ),

                      SizedBox(height: context.screenHeight * 0.1),
                      Obx(
                        () => MainButton(
                          title: "Continue",
                          loading: controller.loading.value,
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              if (controller.education.value.isEmpty) {
                                Utils.snackBar(
                                  "Error",
                                  "Please select your highest education",
                                  AppColors.red,
                                );
                                return;
                              }
                              if (controller.employedIn.value.isEmpty) {
                                Utils.snackBar(
                                  "Error",
                                  "Please select your employment type",
                                  AppColors.red,
                                );
                                return;
                              }
                              if (controller.occupation.value.isEmpty) {
                                Utils.snackBar(
                                  "Error",
                                  "Please select your occupation",
                                  AppColors.red,
                                );
                                return;
                              }
                              if (controller.annualIncome.value.isEmpty) {
                                Utils.snackBar(
                                  "Error",
                                  "Please select your annual income",
                                  AppColors.red,
                                );
                                return;
                              }
                              if (controller.workLocation.value.isEmpty) {
                                Utils.snackBar(
                                  "Error",
                                  "Please select your work location",
                                  AppColors.red,
                                );
                                return;
                              }
                              if (controller.selectedState.value.isEmpty) {
                                Utils.snackBar(
                                  "Error",
                                  "Please select state",
                                  AppColors.red,
                                );
                                return;
                              }
                              if (controller.selectedCity.value.isEmpty) {
                                Utils.snackBar(
                                  "Error",
                                  "Please select city",
                                  AppColors.red,
                                );
                                return;
                              }

                              // ✅ Firestore save
                              controller.saveProfessionalDetails();
                            }
                          },
                        ),
                      ),
                      AppSizes.spaceLg.heightBox,
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
