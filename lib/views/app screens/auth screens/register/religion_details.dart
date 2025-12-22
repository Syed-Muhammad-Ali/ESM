import 'package:european_single_marriage/controller/auth%20controller/auth_controller.dart';
import 'package:european_single_marriage/core/common/custom_drop_down.dart';
import 'package:european_single_marriage/core/common/custom_text.dart';
import 'package:european_single_marriage/core/common/custom_textfield.dart';
import 'package:european_single_marriage/core/common/main_button.dart';
import 'package:european_single_marriage/core/extensions/media_query.dart';
import 'package:european_single_marriage/core/extensions/size_box_extension.dart';
import 'package:european_single_marriage/core/utils/constant/app_colors.dart';
import 'package:european_single_marriage/core/utils/constant/app_sizes.dart';
import 'package:european_single_marriage/core/utils/snackBar/snackbar_utils.dart';
import 'package:european_single_marriage/views/screens%20widgets/auth%20widget/register_header.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';

class ReligionDetails extends StatelessWidget {
  final controller = Get.find<AuthController>();
  final _formKey = GlobalKey<FormState>();

  ReligionDetails({super.key});

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
                  step: 2,
                  title: "Religion Details",
                  subtitle: "Next Step: Personal Details",
                  backStep: "Basic Details",
                  heading: "Please provide your religion details:",
                ),

                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Religion Dropdown
                      Obx(
                        () => CustomDropdown(
                          hint: "Select Religion",
                          title: "Religion",
                          items: controller.religionOptions,
                          value: controller.selectedReligion.value,
                          onChanged:
                              (val) => controller.updateReligion(val ?? ''),
                        ),
                      ),
                      AppSizes.spaceSm.heightBox,

                      Obx(
                        () => CheckboxListTile(
                          contentPadding: EdgeInsets.zero,
                          activeColor: AppColors.primaryColor,
                          value: controller.willingToMarryOtherCaste.value,
                          onChanged:
                              (val) =>
                                  controller.willingToMarryOtherCaste.value =
                                      val ?? false,
                          title: CustomText(
                            title: "Willing to marry from other caste also",
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.gray1,
                          ),
                          controlAffinity: ListTileControlAffinity.leading,
                          visualDensity: const VisualDensity(horizontal: -4),
                        ),
                      ),
                      AppSizes.spaceSm.heightBox,
                      CustomTextField(
                        title: "Caste",
                        hintText: "Enter Caste",
                        keyboardType: TextInputType.multiline,
                        controller: controller.casteCtrl.value,
                        validator:
                            MultiValidator([
                              RequiredValidator(
                                errorText: "Please enter your caste",
                              ),
                            ]).call,
                      ),
                      // Caste
                      // Obx(
                      //   () => CustomDropdown(
                      //     hint: "Select Caste",
                      //     title: "Caste",
                      //     items: [], // TODO: caste list load from backend
                      //     value: controller.selectedCaste.value,
                      //     onChanged: (val) => controller.updateCaste(val ?? ''),
                      //   ),
                      // ),
                      AppSizes.spaceSm.heightBox,
                      CustomTextField(
                        title: "Sub aste",
                        hintText: "Enter Sub Caste",
                        keyboardType: TextInputType.multiline,
                        controller: controller.subCasteCtrl.value,
                        validator:
                            MultiValidator([
                              RequiredValidator(
                                errorText: "Please enter yoursub caste",
                              ),
                            ]).call,
                      ),

                      // // Sub Caste
                      // Obx(
                      //   () => CustomDropdown(
                      //     hint: "Select Sub Caste",
                      //     title: "Sub Caste",
                      //     items: [],
                      //     value: controller.selectedSubCaste.value,
                      //     onChanged:
                      //         (val) => controller.updateSubCaste(val ?? ''),
                      //   ),
                      // ),
                      SizedBox(height: context.screenHeight * 0.1),

                      // Continue Button
                      Obx(
                        () => MainButton(
                          title: "Continue",
                          loading: controller.loading.value,
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              if (controller.selectedReligion.value.isEmpty) {
                                Utils.snackBar(
                                  "Error",
                                  "Please select your religion",
                                  AppColors.red,
                                );
                                return;
                              }

                              controller.saveReligionDetails();
                            }
                          },
                        ),
                      ),
                      AppSizes.spaceMd.heightBox,
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
