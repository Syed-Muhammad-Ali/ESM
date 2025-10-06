import 'dart:developer';

import 'package:european_single_marriage/controller/network_aware_controller.dart';
import 'package:european_single_marriage/core/utils/constant/app_collections.dart';
import 'package:european_single_marriage/core/utils/constant/app_colors.dart';
import 'package:european_single_marriage/core/utils/snackBar/snackbar_utils.dart';
import 'package:european_single_marriage/data/response/status.dart';
import 'package:european_single_marriage/model/user_model.dart';
import 'package:european_single_marriage/services/firebase_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AddFriendController extends GetxController with NetworkAwareController {
  final rxRequestStatus = Status.LOADING.obs;
  final errorMessage = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  final FirebaseService firebaseServices = Get.find<FirebaseService>();

  /// --- Model  --- ///
  final RxList<UserModel> userList = <UserModel>[].obs;

  /// --- Fetch User for Friend --- ///
  Future<void> fetchUsersForFriends() async {
    if (!await checkConnection(
      statusController: rxRequestStatus,
      errorController: errorMessage,
    )) {
      return;
    }

    try {
      setRxRequestStatus(Status.LOADING);
      errorMessage.value = "";

      final currentUserId = FirebaseAuth.instance.currentUser!.uid;
      log("📌 Current User ID: $currentUserId");

      final users = await firebaseServices
          .getDataFromFirestore<List<UserModel>>(
            collection: AppCollections.users,
            fromJson: (jsonList) {
              return (jsonList as List)
                  .map(
                    (json) => UserModel.fromJson(json as Map<String, dynamic>),
                  )
                  .where((user) => user.id != currentUserId)
                  .toList();
            },
          );

      if (users != null && users.isNotEmpty) {
        for (var user in users) {
          log("👤 User -> ID: ${user.id}, Name: ${user.name}");
        }
        userList.assignAll(users);
        setRxRequestStatus(Status.COMPLETED);
      } else {
        log("⚠️ No users found!");
        errorMessage.value = "No users found!";
        setRxRequestStatus(Status.ERROR);
      }
    } catch (error) {
      errorMessage.value = "Failed to fetch users: $error";
      log("❌ Error in fetchUsersForFriends: $error");
      setRxRequestStatus(Status.ERROR);
      Utils.snackBar("Error", errorMessage.value, AppColors.red);
    }
  }
}
