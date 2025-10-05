import 'dart:developer';

import 'package:european_single_marriage/controller/network_aware_controller.dart';
import 'package:european_single_marriage/core/utils/constant/app_collections.dart';
import 'package:european_single_marriage/core/utils/constant/app_colors.dart';
import 'package:european_single_marriage/core/utils/snackBar/snackbar_utils.dart';
import 'package:european_single_marriage/data/response/status.dart';
import 'package:european_single_marriage/model/tab_items.dart';
import 'package:european_single_marriage/model/user_model.dart';
import 'package:european_single_marriage/services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MatchesController extends GetxController with NetworkAwareController {
  final rxRequestStatus = Status.LOADING.obs;
  final errorMessage = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  final FirebaseService firebaseServices = Get.find<FirebaseService>();

  final selectedDiscountType = 'Fix'.obs;
  final RxList<TabItems> tabs =
      [
        TabItems(image: 'assets/svg/filters.svg', text: 'Filters'),
        TabItems(text: 'Match Preference'),
        TabItems(text: 'Basic Details'),
        TabItems(text: 'Religious Details'),
        TabItems(text: 'Profissional Details'),
        TabItems(text: 'Location Details'),
        TabItems(text: 'Family Details'),
      ].obs;

  RxString profileInterested = ''.obs;
  // Basic Details
  final TextEditingController dob = TextEditingController();
  final TextEditingController age = TextEditingController();
  final TextEditingController motherTongue = TextEditingController();
  final TextEditingController eatingHabits = TextEditingController();
  final TextEditingController smokingHabits = TextEditingController();
  final TextEditingController drinkingHabits = TextEditingController();
  final TextEditingController profileCreatedBy = TextEditingController();
  final TextEditingController maritalStatus = TextEditingController();
  final TextEditingController livesIn = TextEditingController();
  final TextEditingController citizen = TextEditingController();

  // Religion Details
  final TextEditingController religion = TextEditingController();
  final TextEditingController caste = TextEditingController();
  final TextEditingController gothram = TextEditingController();
  final TextEditingController dosham = TextEditingController();

  // Professional Details
  final TextEditingController employment = TextEditingController();

  // Educational Details
  final TextEditingController degree = TextEditingController();
  final TextEditingController university = TextEditingController();

  // Family Details
  final TextEditingController familyType = TextEditingController();
  final TextEditingController parents = TextEditingController();
  final TextEditingController ancestralOrigin = TextEditingController();

  /// --- User Model  --- ///
  Rx<List<UserModel>> usersData = Rx<List<UserModel>>([]);
  Rx<UserModel?> matchDetails = Rx<UserModel?>(null);

  Future<void> fetchUsers() async {
    if (!await checkConnection(
      statusController: rxRequestStatus,
      errorController: errorMessage,
    )) {
      return;
    }
    try {
      setRxRequestStatus(Status.LOADING);
      errorMessage.value = "";

      List<UserModel>? users = await firebaseServices
          .getDataFromFirestore<List<UserModel>>(
            collection: AppCollections.users,
            fromJson:
                (jsonList) =>
                    (jsonList as List)
                        .map(
                          (json) =>
                              UserModel.fromJson(json as Map<String, dynamic>),
                        )
                        .toList(),
          );

      if (users != null && users.isNotEmpty) {
        usersData.value = users;
        log("Fetched UserModel: ${users.length}");
        setRxRequestStatus(Status.COMPLETED);
      } else {
        errorMessage.value = "No user data found!";
        setRxRequestStatus(Status.ERROR);
      }
    } catch (error) {
      errorMessage.value = "Failed to fetch coupon: $error";
      log("error : $error");
      setRxRequestStatus(Status.ERROR);
      Utils.snackBar("Error", errorMessage.value, AppColors.red);
    }
  }
}
