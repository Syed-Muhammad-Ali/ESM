import 'package:european_single_marriage/controller/auth%20controller/auth_controller.dart';
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

class BasicDetails extends StatelessWidget {
  // final controller = Get.put(AuthController());
  final controller = Get.find<AuthController>();
  final _formKey = GlobalKey<FormState>();

  BasicDetails({super.key});

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
                  step: 1,
                  title: "Basic Details",
                  subtitle: "Next Step: Religion Details",
                  heading: "Please provide your basic details:",
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.paddingSH,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextField(
                        title: "Age",
                        hintText: "26",
                        keyboardType: TextInputType.number,
                        controller: controller.agelCtrl.value,
                        validator:
                            MultiValidator([
                              RequiredValidator(
                                errorText: "Please enter your age",
                              ),
                            ]).call,
                      ),
                      CustomTextField(
                        title: "Date Of Birth:",
                        keyboardType: TextInputType.text,
                        hintText: "",
                        controller: controller.doblCtrl.value,
                        validator:
                            MultiValidator([
                              RequiredValidator(
                                errorText: "Please enter your date of birth",
                              ),
                            ]).call,
                      ),
                      CustomTextField(
                        controller: controller.mobileNumber.value,
                        title: "Mobile Number",
                        keyboardType: TextInputType.phone,
                        hintText: "",
                        validator:
                            MultiValidator([
                              RequiredValidator(
                                errorText: "Please enter your mobile number",
                              ),
                              // MinLengthValidator(
                              //   10,
                              //   errorText: "Enter valid mobile number",
                              // ),
                            ]).call,
                      ),
                      AppSizes.spaceMd.heightBox,

                      CustomToggleSelector(
                        title: "Gender",
                        options: ['Male', 'Female'],
                        selectedValue: controller.selectedGender,
                        onChanged:
                            (value) => controller.selectedGender.value = value,
                      ),

                      SizedBox(height: context.screenHeight * 0.1),
                      Obx(
                        () => MainButton(
                          title: "Continue",
                          loading: controller.loading.value,
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              if (controller.selectedGender.value.isEmpty) {
                                Utils.snackBar(
                                  "Error",
                                  "Please select your gender",
                                  AppColors.red,
                                );
                                return;
                              }
                              controller.saveBasicDetails();
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
