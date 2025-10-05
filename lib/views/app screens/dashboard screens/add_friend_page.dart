import 'dart:developer';

import 'package:european_single_marriage/controller/home%20controller/add_friend_controller.dart';
import 'package:european_single_marriage/controller/home%20controller/message_text_controller.dart';
import 'package:european_single_marriage/core/common/custom_text.dart';
import 'package:european_single_marriage/core/utils/constant/app_colors.dart';
import 'package:european_single_marriage/core/utils/constant/app_images.dart';
import 'package:european_single_marriage/core/utils/snackBar/snackbar_utils.dart';
import 'package:european_single_marriage/data/response/status.dart';
import 'package:european_single_marriage/data/storage/app_storage.dart';
import 'package:european_single_marriage/views/app%20screens/dashboard%20screens/chat_text_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddFriendPage extends StatefulWidget {
  const AddFriendPage({super.key});

  @override
  State<AddFriendPage> createState() => _AddFriendPageState();
}

class _AddFriendPageState extends State<AddFriendPage> {
  final addFrindCtrl = Get.put(AddFriendController());
  final messageCtrl = Get.put(MessageController());

  @override
  void initState() {
    addFrindCtrl.fetchUsersForFriends();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            color: const Color(0xFFFFD2A2),
            child: SafeArea(
              child: AppBar(
                backgroundColor: const Color(0xFFFFD2A2),
                leading: const BackButton(),
                centerTitle: true,
                title: const CustomText(
                  title: "Add Friend",
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              if (addFrindCtrl.rxRequestStatus.value == Status.LOADING) {
                return const Center(child: CircularProgressIndicator());
              }
              if (addFrindCtrl.rxRequestStatus.value == Status.ERROR) {
                return Center(child: Text(addFrindCtrl.errorMessage.value));
              }
              return ListView.builder(
                itemCount: addFrindCtrl.userList.length,
                itemBuilder: (context, index) {
                  final user = addFrindCtrl.userList[index];
                  return ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage:
                          (user.profileImages != null &&
                                  user.profileImages!.isNotEmpty)
                              ? NetworkImage(user.profileImages!.first)
                              : AssetImage(AppImages.imageURL) as ImageProvider,
                    ),
                    title: CustomText(
                      title: user.name ?? "Unknown",
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                    onTap: () async {
                      final currentUserId = await AppStorage.getUserID();
                      if (currentUserId == null) {
                        log("❌ No current user ID found!");
                        Utils.snackBar(
                          "Error",
                          "User not logged in properly",
                          AppColors.red,
                        );
                        return;
                      }

                      final chatId = await messageCtrl.createUniqueId(
                        senderId: currentUserId,
                        receiverId: user.id!,
                      );

                      Get.to(
                        () => MessageTextPage(
                          chatId: chatId,
                          receiverId: user.id!,
                          userName: user.name ?? "Unknown",
                          userImage:
                              (user.profileImages != null &&
                                      user.profileImages!.isNotEmpty)
                                  ? user.profileImages!.first
                                  : AppImages.imageURL,
                        ),
                      );
                    },
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
