import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:european_single_marriage/controller/home%20controller/dashboard_controller.dart';
import 'package:european_single_marriage/controller/network_aware_controller.dart';
import 'package:european_single_marriage/core/utils/constant/app_collections.dart';
import 'package:european_single_marriage/core/utils/constant/app_colors.dart';
import 'package:european_single_marriage/data/response/status.dart';
import 'package:european_single_marriage/data/storage/app_storage.dart';
import 'package:european_single_marriage/services/firebase_service.dart';
import 'package:european_single_marriage/views/app%20screens/dashboard%20screens/dashboard.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../core/utils/constant/app_keys.dart';
import '../../core/utils/snackBar/snackbar_utils.dart';

class EditProfileController extends GetxController with NetworkAwareController {
  RxBool loading = false.obs;
  RxBool isPasswordHidden = true.obs;

  final rxRequestStatus = Status.LOADING.obs;
  final errorMessage = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  final FirebaseService firebaseServices = Get.find<FirebaseService>();

  @override
  void onInit() {
    editMode();
    super.onInit();
  }

  var isProfilePic = false.obs;
  var profilePicPath = "".obs;
  var profileImageUrl = "".obs;
  var pickedImage = Rx<File?>(null);

  void setProfileImagePath(String path) {
    profilePicPath.value = path;
    isProfilePic.value = true;
    pickedImage.value = File(path);
  }

  var selectedReligion = ''.obs;
  // var selectedCaste = ''.obs;
  // var selectedSubCaste = ''.obs;
  var materialStatus = ''.obs;

  List<String> maritalStatusOptions = ['Married', 'Unmarried', 'Divorced'];
  final List<String> religionOptions = [
    "Islam",
    "Christianity",
    "Hinduism",
    "Buddhism",
    "Sikhism",
    "Judaism",
    "Bahá'í Faith",
    "Jainism",
    "Zoroastrianism",
    "Taoism",
    "Shinto",
    "Confucianism",
    "Agnostic",
    "Atheist",
    "Spiritual but not religious",
    "Paganism",
    "Animism",
    "Druidism",
    "Rastafarianism",
    "Unitarian Universalism",
    "Prefer not to say",
    "Other",
  ];

  void updateReligion(String value) => selectedReligion.value = value;

  /// --- Controller --- ///
  var fullName = TextEditingController().obs;
  var email = TextEditingController().obs;
  var mobileNo = TextEditingController().obs;
  var age = TextEditingController().obs;
  var caste = TextEditingController().obs;
  var subCaste = TextEditingController().obs;

  Future<void> editMode() async {
    // Basic fields
    fullName.value.text = AppStorage.userData.value.name ?? '';
    email.value.text = AppStorage.userData.value.email ?? '';
    mobileNo.value.text = AppStorage.userData.value.mobileNo ?? '';
    age.value.text = AppStorage.userData.value.age ?? '';

    // Religion & caste
    selectedReligion.value = AppStorage.userData.value.religion ?? '';
    caste.value.text = AppStorage.userData.value.caste ?? '';
    subCaste.value.text = AppStorage.userData.value.subCaste ?? '';

    // Marital status
    materialStatus.value = AppStorage.userData.value.maritalStatus ?? '';

    // Profile image (from Firestore/RealtimeDB)
    if (AppStorage.userData.value.userProfilePic != null &&
        AppStorage.userData.value.userProfilePic!.isNotEmpty) {
      profileImageUrl.value = AppStorage.userData.value.userProfilePic!;
    }

    print("name : ${AppStorage.userData.value.religion}");
  }

  /// --- Update Profile ---
  Future<void> updateProfile() async {
    if (!await checkConnection(
      statusController: rxRequestStatus,
      errorController: errorMessage,
    )) {
      return;
    }
    try {
      loading.value = true;
      setRxRequestStatus(Status.LOADING);
      String userId = await AppStorage.getUserID();

      // 🔁 Upload image now if picked
      String? uploadedUrl = profileImageUrl.value;
      if (pickedImage.value != null) {
        final uploaded = await firebaseServices.uploadFileToStorage(
          file: pickedImage.value!,
          path: 'users/$userId/profile.jpg',
        );
        if (uploaded != null) {
          uploadedUrl = uploaded;
          profileImageUrl.value = uploadedUrl;
        }
      }

      Map<String, dynamic> data = {
        'id': userId,
        "name": fullName.value.text.trim(),
        "mobileNo": mobileNo.value.text.trim(),
        "email": email.value.text.trim(),
        "age": age.value.text.trim(),
        "religion": selectedReligion.value,
        "caste": caste.value.text.trim(),
        "subCaste": subCaste.value.text.trim(),
        "maritalStatus": materialStatus.value,
        'userProfilePic': uploadedUrl,
        'updatedAt': FieldValue.serverTimestamp(),
      };
      await firebaseServices.updateDataToFirestore(
        data: data,
        collection: AppCollections.users,
        id: userId,
      );

      // await firebaseServices.updateFieldWhere(
      //   collection: AppCollections.users,
      //   fieldName: 'userId',
      //   isEqualTo: userId,
      //   updateFields: {
      //     'imamProfileImage':
      //         "$profileImageUrl?v=${DateTime.now().millisecondsSinceEpoch}",
      //   },
      // );

      final updatedUser = await firebaseServices.getUserData(uid: userId);
      if (updatedUser != null) {
        await AppStorage.storeLocalUser(AppKeys.userData, updatedUser.toJson());
        await AppStorage.getLocalUser(AppKeys.userData);
        await AppStorage.setUserID(updatedUser.id);
      }
      loading.value = false;
      setRxRequestStatus(Status.COMPLETED);
      // clearController();
      Get.offAll(() => DashboardScreen());
      DashboardController.to.changeTabIndex(3);
      Utils.snackBar(
        "Success",
        "Profile updated successfully!",
        AppColors.green,
      );
    } catch (error) {
      loading.value = false;
      setRxRequestStatus(Status.ERROR);
      errorMessage.value = error.toString();
      Utils.snackBar(
        "Error",
        "Failed to update profile: ${error.toString()}",
        AppColors.red,
      );
    }
  }
}
