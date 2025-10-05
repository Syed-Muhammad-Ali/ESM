// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:european_single_marriage/controller/home%20controller/edit_profile_controller.dart';
import 'package:european_single_marriage/core/common/custam_container.dart';
import 'package:european_single_marriage/core/common/custom_drop_down.dart';
import 'package:european_single_marriage/core/common/custom_text.dart';
import 'package:european_single_marriage/core/common/main_button.dart';
import 'package:european_single_marriage/core/extensions/size_box_extension.dart';
import 'package:european_single_marriage/core/utils/constant/app_colors.dart';
import 'package:european_single_marriage/core/utils/constant/app_images.dart';
import 'package:european_single_marriage/core/utils/constant/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  File? pickedFile;
  ImagePicker imagePicker = ImagePicker();
  // final _formKey = GlobalKey<FormState>();
  final controller = Get.put(EditProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xFFFFC690),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(62),
                  bottomRight: Radius.circular(62),
                ),
              ),

              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: SafeArea(
                  child: Column(
                    children: [
                      CustomText(
                        title: "Edit Profile",
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                      AppSizes.spaceBtwItems.heightBox,
                      Obx(
                        () => GestureDetector(
                          onTap: () {
                            gallryImage(ImageSource.gallery);
                          },
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage:
                                controller.isProfilePic.value &&
                                        controller
                                            .profilePicPath
                                            .value
                                            .isNotEmpty
                                    ? FileImage(
                                      File(controller.profilePicPath.value),
                                    )
                                    : (controller
                                            .profileImageUrl
                                            .value
                                            .isNotEmpty
                                        ? NetworkImage(
                                          controller.profileImageUrl.value,
                                        )
                                        : AssetImage(AppImages.imageURL)
                                            as ImageProvider),
                          ),
                        ),
                      ),

                      AppSizes.spaceBtwItems.heightBox,
                    ],
                  ),
                ),
              ),
            ),
            AppSizes.spaceBtwItems.heightBox,
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.paddingSH,
              ),
              child: Column(
                children: [
                  CustomContainer(
                    cir: 25,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    color: Color(0xFFEAEBEA),
                    child: Column(
                      children: [
                        AppSizes.spaceBtwSections.heightBox,
                        CustomText(
                          title: "Basic Details",
                          fontSize: 23,
                          fontWeight: FontWeight.w500,
                        ),
                        AppSizes.spaceBtwItems.heightBox,

                        editField(
                          title: "Full Name",
                          hintText: "Teja Khan",
                          controller: controller.fullName.value,
                          validator:
                              MultiValidator([
                                RequiredValidator(
                                  errorText: "Please enter full name",
                                ),
                                // EmailValidator(
                                //   errorText: "Please enter a valid email",
                                // ),
                              ]).call,
                        ),
                        editField(
                          title: "Number",
                          hintText: "03436661888",
                          controller: controller.mobileNo.value,
                          validator:
                              MultiValidator([
                                RequiredValidator(
                                  errorText: "Please enter your mobile number",
                                ),
                              ]).call,
                        ),
                        editField(
                          title: "Email",
                          hintText: "teja124@gmail.com",
                          controller: controller.email.value,
                          validator:
                              MultiValidator([
                                RequiredValidator(
                                  errorText: "Please enter your email",
                                ),
                                EmailValidator(
                                  errorText: "Please enter a valid email",
                                ),
                              ]).call,
                        ),
                        editField(
                          title: "Age",
                          hintText: "28",
                          controller: controller.age.value,
                          validator:
                              MultiValidator([
                                RequiredValidator(
                                  errorText: "Please enter your age",
                                ),
                              ]).call,
                        ),
                      ],
                    ),
                  ),
                  AppSizes.spaceBtwItems.heightBox,

                  CustomContainer(
                    cir: 25,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    color: Color(0xFFEAEBEA),
                    child: Column(
                      children: [
                        AppSizes.spaceBtwSections.heightBox,
                        CustomText(
                          title: "Religion Details",
                          fontSize: 23,
                          fontWeight: FontWeight.w500,
                        ),
                        AppSizes.spaceBtwItems.heightBox,
                        Obx(
                          () => CustomDropdown(
                            color: AppColors.white,
                            borders: false,
                            hint: "Select Religion",
                            title: "Religion",
                            items: controller.religionOptions,
                            value:
                                controller.selectedReligion.value.isNotEmpty
                                    ? controller.selectedReligion.value
                                    : '',
                            onChanged:
                                (val) => controller.updateReligion(val ?? ''),
                          ),
                        ),
                        editField(
                          title: "Caste",
                          hintText: "Enter Caste",
                          controller: controller.caste.value,
                          validator:
                              MultiValidator([
                                RequiredValidator(
                                  errorText: "Please enter your caste",
                                ),
                              ]).call,
                        ),
                        editField(
                          title: "Sub Caste",
                          hintText: "Enter Sub Caste",
                          controller: controller.subCaste.value,
                          validator:
                              MultiValidator([
                                RequiredValidator(
                                  errorText: "Please enter your sub caste",
                                ),
                              ]).call,
                        ),

                        // Obx(
                        //   () => CustomDropdown(
                        //     hint: "",
                        //     title: "Caste",
                        //     color: AppColors.white,
                        //     borders: false,
                        //     items: [],
                        //     value: controller.selectedCaste.value,
                        //     onChanged: (val) {
                        //       (val) => controller.selectedCaste(val!);
                        //     },
                        //   ),
                        // ),
                        // Obx(
                        //   () => CustomDropdown(
                        //     hint: "",
                        //     title: "Sub Caste",
                        //     color: AppColors.white,
                        //     borders: false,
                        //     items: [],
                        //     value: controller.selectedSubCaste.value,
                        //     onChanged: (val) {
                        //       (val) => controller.selectedSubCaste(val!);
                        //     },
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  AppSizes.spaceBtwItems.heightBox,
                  CustomContainer(
                    cir: 25,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    color: Color(0xFFEAEBEA),
                    child: Column(
                      children: [
                        AppSizes.spaceBtwSections.heightBox,
                        CustomText(
                          title: "Personal Details",
                          fontSize: 23,
                          fontWeight: FontWeight.w500,
                        ),
                        AppSizes.spaceBtwItems.heightBox,
                        Obx(
                          () => CustomDropdown(
                            hint: "Select Marital Status",
                            title: "Marital Status",
                            color: AppColors.white,
                            borders: false,
                            items: controller.maritalStatusOptions,
                            value:
                                controller.materialStatus.value.isNotEmpty
                                    ? controller.materialStatus.value
                                    : '',
                            onChanged:
                                (val) =>
                                    controller.materialStatus.value = val ?? '',
                          ),
                        ),
                        AppSizes.spaceBtwItems.heightBox,
                      ],
                    ),
                  ),
                  AppSizes.spaceBtwSections.heightBox,
                  Obx(
                    () => MainButton(
                      width: 193,
                      loading: controller.loading.value,
                      title: "Save",
                      onPressed: () {
                        // if (_formKey.currentState!.validate()) {
                        // if (controller.materialStatus.value.isEmpty) {
                        //   Utils.snackBar(
                        //     "Error",
                        //     "Please select your marital status",
                        //     AppColors.red,
                        //   );
                        //   return;
                        // }

                        controller.updateProfile();
                        // }
                      },
                    ),
                  ),
                  AppSizes.spaceBtwSections.heightBox,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget editField({
    required String title,
    required String hintText,
    TextEditingController? controller,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          title: title,
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: Color(0xFF7A7A7A),
        ),
        CustomContainer(
          color: AppColors.white,
          cir: 12,
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: TextFormField(
            controller: controller,
            validator: validator,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintText,
              contentPadding: EdgeInsets.symmetric(vertical: 12),
              suffixIcon: Icon(Icons.edit),
            ),
          ),
        ),
        AppSizes.spaceBtwItems.heightBox,
      ],
    );
  }

  Future<void> gallryImage(ImageSource source) async {
    final pickedImage = await imagePicker.pickImage(
      source: source,
      imageQuality: 100,
    );
    pickedFile = File(pickedImage!.path);
    controller.setProfileImagePath(pickedFile!.path);
  }
}
