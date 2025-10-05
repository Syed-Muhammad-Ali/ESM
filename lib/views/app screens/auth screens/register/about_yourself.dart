// ignore_for_file: use_build_context_synchronously

import 'package:dotted_border/dotted_border.dart';
import 'package:european_single_marriage/controller/auth%20controller/auth_controller.dart';
import 'package:european_single_marriage/core/common/custam_container.dart';
import 'package:european_single_marriage/core/common/custom_text.dart';
import 'package:european_single_marriage/core/common/custom_textfield.dart';
import 'package:european_single_marriage/core/common/main_button.dart';
import 'package:european_single_marriage/core/extensions/media_query.dart';
import 'package:european_single_marriage/core/extensions/size_box_extension.dart';
import 'package:european_single_marriage/core/utils/constant/app_colors.dart';
import 'package:european_single_marriage/core/utils/constant/app_sizes.dart';
import 'package:european_single_marriage/core/utils/snackBar/snackbar_utils.dart';
import 'package:european_single_marriage/routes/app_routes.dart';
import 'package:european_single_marriage/views/screens%20widgets/auth%20widget/register_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AboutYourself extends StatelessWidget {
  final controller = Get.find<AuthController>();
  final _formKey = GlobalKey<FormState>();
  AboutYourself({super.key});

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
                  step: 5,
                  title: "About Yourself",
                  backStep: "Professional Details",
                  heading: "Please provide your about yourself:",
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.paddingSH,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextField(
                        title: "About Yourself:",
                        //  maxLines: 5,
                        hintText: "No",
                        controller: controller.aboutYourselflCtrl.value,
                      ),

                      AppSizes.spaceBtwItems.heightBox,
                      CustomText(
                        title: "Upload Image (Min. 3 images):",
                        fontWeight: FontWeight.w400,
                        color: AppColors.gray1,
                      ),
                      DottedBorderBox(onUploadPressed: () {}),
                      SizedBox(height: context.screenHeight * 0.1),
                      Obx(
                        () => MainButton(
                          title: "Complete Registration",
                          loading: controller.loading.value,
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              if (controller.pickedImages.length < 3) {
                                Utils.snackBar(
                                  "Upload Required",
                                  "Please upload at least 3 images",
                                  AppColors.red,
                                );
                                return;
                              }
                              bool success =
                                  await controller.saveAboutYourself();
                              if (success) {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      contentPadding: EdgeInsets.zero,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: AppSizes.paddingSH,
                                              vertical: AppSizes.paddingSV,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Color(0xFFFFC690),
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(16),
                                                topRight: Radius.circular(16),
                                              ),
                                            ),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: CustomText(
                                                title: "Registration Success",
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          AppSizes.spaceBtwItems.heightBox,
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: AppSizes.md,
                                              vertical: AppSizes.paddingSV,
                                            ),
                                            child: Column(
                                              children: [
                                                Icon(
                                                  Icons.thumb_up_alt_outlined,
                                                  color: AppColors.primaryColor,
                                                  size: 60,
                                                ),
                                                AppSizes.sm.heightBox,
                                                CustomText(
                                                  title: "Success",
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                AppSizes.xs.heightBox,
                                                CustomText(
                                                  title:
                                                      "Your registration has been completed successfully. Please login to your app to see better matches.",
                                                  color:
                                                      AppColors.lightsubblack,
                                                  textAlign: TextAlign.center,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                AppSizes
                                                    .spaceBtwSections
                                                    .heightBox,
                                                MainButton(
                                                  title: "Go To Home",
                                                  fontSize: 14,
                                                  onPressed: () {
                                                    Get.offAllNamed(
                                                      AppRoutes.dashboardScreen,
                                                    );
                                                  },
                                                ),
                                                AppSizes
                                                    .spaceBtwItems
                                                    .heightBox,
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              }
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

class DottedBorderBox extends StatelessWidget {
  final VoidCallback onUploadPressed;

  DottedBorderBox({super.key, required this.onUploadPressed});

  final AuthController controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      color: Colors.grey,
      strokeWidth: 1,
      dashPattern: [6, 3],
      borderType: BorderType.RRect,
      radius: const Radius.circular(10),
      child: CustomContainer(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        child: Obx(() {
          final images = controller.pickedImages;

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (images.isNotEmpty) ...[
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: images.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                  ),
                  itemBuilder: (context, index) {
                    return Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(
                            images[index],
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                        ),
                        Positioned(
                          right: 3,
                          top: 2,
                          child: GestureDetector(
                            onTap: () {
                              controller.pickedImages.removeAt(index);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                color: Colors.black54,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.close,
                                size: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                AppSizes.spaceBtwItems.heightBox,
              ],

              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.file_upload_outlined,
                      size: 40,
                      color: AppColors.iconColor,
                    ),
                    onPressed: () {
                      controller.pickFromGallery();
                      onUploadPressed();
                    },
                  ),
                  AppSizes.spaceBtwItems.heightBox,
                  const CustomText(
                    title: "Drag & Drop files here",
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.gray1,
                  ),
                  AppSizes.spaceBtwItems.heightBox,
                  const CustomText(
                    title: "(or)",
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.gray1,
                  ),
                  AppSizes.spaceBtwItems.heightBox,
                  MainButton(
                    height: 40,
                    width: 130,
                    title: "Browse",
                    fontSize: 14,
                    backgroundColor: AppColors.orange,
                    onPressed: () {
                      controller.pickFromFileBrowser();
                      onUploadPressed();
                    },
                  ),
                ],
              ),
            ],
          );
        }),
      ),
    );
  }
}
