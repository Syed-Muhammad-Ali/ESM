import 'package:european_single_marriage/controller/auth%20controller/auth_controller.dart';
import 'package:european_single_marriage/core/common/custom_drop_down.dart';
import 'package:european_single_marriage/core/common/custom_textfield.dart';
import 'package:european_single_marriage/core/common/custom_toggle_selector.dart';
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

class PersonalDetails extends StatelessWidget {
  final controller = Get.find<AuthController>();
  final _formKey = GlobalKey<FormState>();
  PersonalDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RegisterHeader(
                  step: 3,
                  title: "Personal Details",
                  subtitle: "Next Step: Professional Details",
                  backStep: "Religion Details",
                  heading: "Please provide your personal details:",
                ),

                Obx(
                  () => CustomDropdown(
                    title: "Marital Status",
                    hint: "Select Marital Status",
                    items: controller.maritalStatusOptions,
                    value: controller.maritalStatus.value,
                    onChanged:
                        (val) => controller.maritalStatus.value = val ?? '',
                  ),
                ),

                Obx(
                  () => CustomDropdown(
                    title: "No. of Children",
                    hint: "Select",
                    items: controller.childrenOptions,
                    value: controller.numberOfChildren.value,
                    onChanged:
                        (val) => controller.numberOfChildren.value = val ?? '',
                  ),
                ),

                CustomToggleSelector(
                  title: "Is Children living with you?",
                  options: ['Yes', 'No'],
                  selectedValue: controller.isChildrenLivingWithYou,
                  onChanged:
                      (val) => controller.isChildrenLivingWithYou.value = val,
                ),

                CustomDropdown(
                  title: "Height",
                  hint: "Select Height",
                  items: controller.heightOption,
                  value: controller.height.value,
                  onChanged: (val) => controller.height.value = val ?? '',
                ),

                CustomDropdown(
                  title: "Family Status",
                  hint: "Select Family Status",
                  items: controller.familyStatusOptions,
                  value: controller.familyStatus.value,
                  onChanged: (val) => controller.familyStatus.value = val ?? '',
                ),
                CustomToggleSelector(
                  title: "Family Type",
                  options: ['Joint', 'Nuclear'],
                  selectedValue: controller.familyType,
                  onChanged: (val) => controller.updateFamilyType(val),
                ),
                CustomTextField(
                  title: "Family Values",
                  hintText: "Enter Family Values",
                  controller: controller.familyValueslCtrl.value,
                  validator:
                      MultiValidator([
                        RequiredValidator(
                          errorText: "Please enter your family values",
                        ),
                      ]).call,
                ),
                CustomToggleSelector(
                  title: "Any Disability",
                  options: ['Yes', 'No'],
                  selectedValue: controller.anyDisability,
                  onChanged: (val) => controller.updateanyDisability(val),
                ),
                SizedBox(height: context.screenHeight * 0.1),
                Obx(
                  () => MainButton(
                    title: "Continue",
                    loading: controller.loading.value,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (controller.maritalStatus.value.isEmpty) {
                          Utils.snackBar(
                            "Error",
                            "Please select your marital status",
                            AppColors.red,
                          );
                          return;
                        }

                        if (controller.height.value.isEmpty) {
                          Utils.snackBar(
                            "Error",
                            "Please select your height",
                            AppColors.red,
                          );
                          return;
                        }

                        if (controller.familyStatus.value.isEmpty) {
                          Utils.snackBar(
                            "Error",
                            "Please select your family status",
                            AppColors.red,
                          );
                          return;
                        }

                        if (controller.familyType.value.isEmpty) {
                          Utils.snackBar(
                            "Error",
                            "Please select your family type",
                            AppColors.red,
                          );
                          return;
                        }

                        if (controller.familyValueslCtrl.value.text
                            .trim()
                            .isEmpty) {
                          Utils.snackBar(
                            "Error",
                            "Please enter your family values",
                            AppColors.red,
                          );
                          return;
                        }
                        controller.savePersonalDetails();
                      }
                    },
                  ),
                ),

                AppSizes.spaceMd.heightBox,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
