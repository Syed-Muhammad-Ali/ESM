import 'package:european_single_marriage/controller/network_aware_controller.dart';
import 'package:european_single_marriage/core/utils/constant/app_colors.dart';
import 'package:european_single_marriage/core/utils/constant/app_keys.dart';
import 'package:european_single_marriage/core/utils/snackBar/snackbar_utils.dart';
import 'package:european_single_marriage/data/response/status.dart';
import 'package:european_single_marriage/data/storage/app_storage.dart';
import 'package:european_single_marriage/services/auth_service.dart';
import 'package:european_single_marriage/services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class DeleteAccountController extends GetxController
    with NetworkAwareController {
  RxBool isDeleting = false.obs;
  final rxRequestStatus = Status.LOADING.obs;
  final errorMessage = ''.obs;
  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  final _authService = AuthService();
  final _firestoreService = FirebaseService();

  /// --- Confrim Delete Dailog ---
  Future<void> confirmAndDelete() async {
    final confirmed = await Get.dialog<bool>(
      AlertDialog(
        // backgroundColor: AppColors.primary,
        title: Text(
          "Are you sure?",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            color: AppColors.black,
            fontWeight: FontWeight.w600,
          ),
        ),

        content: Text(
          "This will permanently delete your account and data",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            color: AppColors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: Text(
              "Cancel",
              style: TextStyle(
                fontSize: 16,
                color: AppColors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          TextButton(
            onPressed: () => Get.back(result: true),
            child: Text(
              "Delete",
              style: TextStyle(
                fontSize: 16,
                color: AppColors.red,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );

    if (confirmed != true) return;
    await deleteAccount();
  }

  /// --- Delete Account API ---
  Future<void> deleteAccount() async {
    if (!await checkConnection(
      statusController: rxRequestStatus,
      errorController: errorMessage,
    )) {
      return;
    }

    try {
      isDeleting.value = true;
      setRxRequestStatus(Status.LOADING);
      final uid = _authService.uid;

      AppStorage.removeLocalUser(AppKeys.userData);
      await AppStorage.clearSharedData();

      await _firestoreService.deleteUserData(uid);
      await _authService.deleteAuthAccount();

      Utils.snackBar(
        "Account Deleted",
        "Your account and all associated data have been permanently deleted.",
        AppColors.green,
      );
      setRxRequestStatus(Status.COMPLETED);
      await Future.delayed(const Duration(seconds: 1));
      SystemNavigator.pop();
    } catch (e) {
      setRxRequestStatus(Status.ERROR);
      errorMessage.value = e.toString();
      Utils.snackBar(
        "Deletion Failed",
        "Sorry, we couldn't delete your account. Please try again later.",
        AppColors.red,
      );
    } finally {
      isDeleting.value = false;
    }
  }
}
