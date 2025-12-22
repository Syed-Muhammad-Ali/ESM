import 'dart:developer';

import 'package:european_single_marriage/controller/auth%20controller/auth_controller.dart';
import 'package:european_single_marriage/controller/auth%20controller/delete_account_controller.dart';
import 'package:european_single_marriage/core/common/custam_container.dart';
import 'package:european_single_marriage/core/common/custom_text.dart';
import 'package:european_single_marriage/core/common/main_button.dart';
import 'package:european_single_marriage/core/extensions/size_box_extension.dart';
import 'package:european_single_marriage/core/utils/constant/app_colors.dart';
import 'package:european_single_marriage/core/utils/constant/app_images.dart';
import 'package:european_single_marriage/core/utils/constant/app_sizes.dart';
import 'package:european_single_marriage/data/storage/app_storage.dart';
import 'package:european_single_marriage/model/user_model.dart';
import 'package:european_single_marriage/routes/app_routes.dart';
import 'package:european_single_marriage/services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final authCtrl = Get.put(AuthController());
  final controller = Get.put(DeleteAccountController());
  UserModel? user;

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  Future<void> getUserData() async {
    final uid = await AppStorage.getUserID();
    user = await FirebaseService().getUserData(uid: uid);
    log("User Data : ${user!.maritalStatus}");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(color: AppColors.appBarColor),
        ),
      );
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 10),
              color: const Color(0xFFFFD2A2),
              child: SafeArea(
                child: AppBar(
                  backgroundColor: const Color(0xFFFFD2A2),
                  leading: BackButton(),
                  centerTitle: true,
                  title: const CustomText(
                    title: "My Profile",
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            AppSizes.spaceBtwItems.heightBox,
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.paddingSH,
                vertical: 6,
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage:
                        (user!.userProfilePic != null &&
                                user!.userProfilePic!.isNotEmpty)
                            ? NetworkImage(user!.userProfilePic!)
                            : AssetImage(AppImages.imageURL) as ImageProvider,
                  ),
                  AppSizes.sm.heightBox,
                  CustomText(
                    title: user!.name ?? '',
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                  CustomText(
                    title: user!.mobileNo ?? '',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  CustomText(
                    title: user!.email ?? '',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),

                  AppSizes.spaceBtwSections.heightBox,

                  profileTile("assets/images/memberShip.png", 'MemberShip', () {
                    Get.toNamed(AppRoutes.membership);
                  }),
                  profileTile("assets/images/edit.png", 'Edit Profile', () {
                    Get.toNamed(AppRoutes.editProfile);
                  }),
                  profileTile("assets/images/setting.png", 'Setting', () {
                    Get.toNamed(AppRoutes.helpSupportScreen);
                  }),

                  AppSizes.spaceBtwItems.heightBox,
                  Obx(
                    () => MainButton(
                      loading: authCtrl.loading.value,
                      title: "Log Out",
                      rightImage: "assets/images/arrowForward.png",
                      backgroundColor: Color(0xFFC26308),
                      onPressed: () {
                        authCtrl.logout();
                      },
                    ),
                  ),
                  AppSizes.spaceBtwItems.heightBox,
                  MainButton(
                    title: "Delete Account",
                    rightImage: "assets/images/arrowForward.png",
                    backgroundColor: Color(0xFFFE1B1F),
                    onPressed: () => controller.confirmAndDelete(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget profileTile(String icon, String title, VoidCallback onTap) {
    return CustomContainer(
      margin: EdgeInsets.only(bottom: AppSizes.paddingSV),
      padding: const EdgeInsets.symmetric(horizontal: 27, vertical: 12),
      color: const Color(0xFFEAEBEA),
      cir: 12,
      child: InkWell(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(icon, height: 30, width: 30),
            CustomText(title: title, fontSize: 16, fontWeight: FontWeight.w500),
            const Icon(Icons.arrow_forward_ios, size: 16),
          ],
        ),
      ),
    );
  }
}
