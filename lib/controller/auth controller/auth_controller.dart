// ignore_for_file: unnecessary_null_comparison

import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:european_single_marriage/controller/network_aware_controller.dart';
import 'package:european_single_marriage/core/utils/constant/app_collections.dart';
import 'package:european_single_marriage/core/utils/constant/app_colors.dart';
import 'package:european_single_marriage/core/utils/constant/app_keys.dart';
import 'package:european_single_marriage/core/utils/snackBar/snackbar_utils.dart';
import 'package:european_single_marriage/data/response/status.dart';
import 'package:european_single_marriage/data/storage/app_storage.dart';
import 'package:european_single_marriage/routes/app_routes.dart';
import 'package:european_single_marriage/services/firebase_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AuthController extends GetxController with NetworkAwareController {
  static AuthController get instance => Get.find();

  RxBool loading = false.obs;
  RxBool isPasswordHidden = true.obs;

  final rxRequestStatus = Status.LOADING.obs;
  final errorMessage = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  final FirebaseService firebaseServices = Get.find<FirebaseService>();

  /// --- Login  Controller --- ///
  final loginUserEmail = TextEditingController().obs;
  final loginPassword = TextEditingController().obs;

  final fullName = TextEditingController().obs;
  final mobileNumber = TextEditingController().obs;
  final registerPassword = TextEditingController().obs;
  final agelCtrl = TextEditingController().obs;
  final doblCtrl = TextEditingController().obs;
  final emailCtrl = TextEditingController().obs;
  final familyValueslCtrl = TextEditingController().obs;
  final aboutYourselflCtrl = TextEditingController().obs;
  final casteCtrl = TextEditingController().obs;
  final subCasteCtrl = TextEditingController().obs;

  var selectedGender = ''.obs;
  var maritalStatus = ''.obs;
  var numberOfChildren = ''.obs;
  var isChildrenLivingWithYou = ''.obs;
  var height = ''.obs;
  var familyStatus = ''.obs;
  var familyType = ''.obs;
  var anyDisability = ''.obs;

  // Religion Details
  var selectedReligion = ''.obs;
  var selectedCaste = ''.obs;
  var selectedSubCaste = ''.obs;
  var willingToMarryOtherCaste = false.obs;

  // Professional Details
  var education = ''.obs;
  var employedIn = ''.obs;
  var occupation = ''.obs;
  var annualIncome = ''.obs;
  var workLocation = ''.obs;
  var selectedState = ''.obs;
  var selectedCity = ''.obs;

  List<String> maritalStatusOptions = ['Married', 'Unmarried', 'Divorced'];
  List<String> childrenOptions = ['0', '1', '2', '3', '4', '5'];
  List<String> heightOption = [
    "4’6”",
    "5’2”",
    "5’3”",
    "6’0”",
    "6’6”",
    "6’9”",
    "7’2”",
  ];

  List<String> familyStatusOptions = [
    'Middle Class',
    'Upper Class',
    'Rich',
    'Normal',
  ];
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

  List<String> educationOptions = [
    'Primary',
    'Middle',
    'Matric',
    'Inter',
    'Bachelor’s',
    'Master’s',
    'M.Phil',
    'Ph.D.',
    'Diploma',
    'Other',
  ];
  List<String> employedInOptions = [
    'Government',
    'Private Sector',
    'Self-employed',
    'Business Owner',
    'Non-profit / NGO',
    'Freelancer',
    'Student',
    'Retired',
    'Unemployed',
    'Other',
  ];

  List<String> occupationOptions = [
    'Student',
    'Teacher',
    'Engineer',
    'Doctor',
    'Nurse',
    'Software Developer',
    'Graphic Designer',
    'Content Writer',
    'Lecturer',
    'Fashion Designer',
    'Beautician',
    'Receptionist',
    'HR Manager',
    'Banker',
    'Air Hostess',
    'Businessman',
    'Businesswoman',
    'Freelancer',
    'Government Employee',
    'Private Employee',
    'Police Officer',
    'Army Officer',
    'Driver',
    'Shopkeeper',
    'Farmer',
    'Laborer',
    'Housewife',
    'Unemployed',
    'Other',
  ];
  final List<String> annualIncomeOptions = [
    'Less than 1 Lakh',
    '1 - 3 Lakh',
    '3 - 5 Lakh',
    '5 - 10 Lakh',
    '10 - 20 Lakh',
    '20+ Lakh',
  ];

  final List<String> stateOptions = [
    'Punjab',
    'Sindh',
    'Khyber Pakhtunkhwa',
    'Balochistan',
    'Islamabad Capital Territory',
  ];

  final List<String> cityOptions = [
    'Lahore',
    'Karachi',
    'Islamabad',
    'Peshawar',
    'Quetta',
    'Multan',
    'Faisalabad',
    'Rawalpindi',
  ];

  List<String> workLocationOptions = ['Remote', 'On-site', 'Hybrid'];
  void updateReligion(String value) => selectedReligion.value = value;
  void updateCaste(String value) => selectedCaste.value = value;
  void updateSubCaste(String value) => selectedSubCaste.value = value;
  void updateFamilyType(String value) => familyType.value = value;
  void updateanyDisability(String value) => anyDisability.value = value;
  void updateisChildrenLivingWithYou(String value) => familyType.value = value;

  // // ==================== Image Picker ===================//
  RxList<File> pickedImages = <File>[].obs;

  Future<void> pickFromGallery() async {
    final picker = ImagePicker();
    final picked = await picker.pickMultiImage();

    if (picked != null) {
      pickedImages.addAll(picked.map((x) => File(x.path)));
    }
  }

  Future<void> pickFromFileBrowser() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.image,
    );

    if (result != null) {
      pickedImages.addAll(result.paths.map((path) => File(path!)));
    }
  }

  /// --- SignUp  --- ///
  Future<void> register() async {
    if (!await checkConnection(
      statusController: rxRequestStatus,
      errorController: errorMessage,
    )) {
      return;
    }

    try {
      loading.value = true;
      setRxRequestStatus(Status.LOADING);

      final name = fullName.value.text.trim();
      final password = registerPassword.value.text.trim();
      final email = emailCtrl.value.text.trim();

      final nameExists = await firebaseServices.isNameTaken(name);
      if (nameExists) {
        Utils.snackBar(
          "Error",
          "This name is already taken. Please try a different name.",
          AppColors.red,
        );
        return;
      }

      final id = await firebaseServices.signUpWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (id == null) {
        throw Exception("Account creation failed. Please try again.");
      }

      Map<String, dynamic> data = {
        'id': id,
        'name': name,
        'email': email,
        'profileStep': 0,
        'profileCompletion': 0,
        'createdAt': FieldValue.serverTimestamp(),
      };

      await firebaseServices.addDataToFirestore(
        data: data,
        collection: AppCollections.users,
        id: id,
      );
      final user = await firebaseServices.getUserData(uid: id);

      if (user != null) {
        await AppStorage.storeLocalUser(AppKeys.userData, user.toJson());
        log("User : ${user.id}");
        log("password : $password");
        log("email : ${user.email}");
        AppStorage.setUserID(user.id);
        await AppStorage.set('email', user.email ?? '');
        await AppStorage.set('name', name);
        await AppStorage.set('password', password);
        // Utils.snackBar("Success", "Welcome, ${user.email}!", AppColors.green);
        Get.toNamed(AppRoutes.basicDetails);
        // Get.offAllNamed(RouteName.selectCategoriesPage);
        clearController();
      } else {
        Utils.snackBar("Error", "User data not found", AppColors.red);
      }

      setRxRequestStatus(Status.COMPLETED);
    } on FirebaseAuthException catch (e) {
      errorMessage.value = e.message ?? "Firebase Auth Error";
      setRxRequestStatus(Status.ERROR);
      Utils.snackBar("Error", e.message ?? "Firebase error", AppColors.red);
    } catch (e) {
      errorMessage.value = e.toString();
      setRxRequestStatus(Status.ERROR);
      Utils.snackBar("Error", e.toString(), AppColors.red);
    } finally {
      loading.value = false;
    }
  }

  /// --- UPDATE PROFILE STEP  --- ///
  Future<void> updateProfileStep(
    int step,
    Map<String, dynamic> stepData,
  ) async {
    if (!await checkConnection(
      statusController: rxRequestStatus,
      errorController: errorMessage,
    )) {
      return;
    }
    try {
      loading.value = true;
      setRxRequestStatus(Status.LOADING);

      final user = FirebaseAuth.instance.currentUser;
      if (user == null) throw Exception("User not logged in");

      final progress = (step / 5) * 100;

      await firebaseServices.updateDataToFirestore(
        collection: AppCollections.users,
        id: user.uid,
        data: {
          'profileStep': step,
          'profileCompletion': progress,
          ...stepData,
          'updatedAt': FieldValue.serverTimestamp(),
        },
      );

      final userData = await firebaseServices.getUserData(uid: user.uid);
      if (userData != null) {
        await AppStorage.storeLocalUser(AppKeys.userData, userData.toJson());
      }
      Utils.snackBar("Success", "Step $step saved!", AppColors.green);
      setRxRequestStatus(Status.COMPLETED);
      clearController();
    } catch (e) {
      errorMessage.value = e.toString();
      setRxRequestStatus(Status.ERROR);
      Utils.snackBar("Error", e.toString(), AppColors.red);
    } finally {
      loading.value = false;
    }
  }

  /// --- STEP FUNCTIONS --- ///
  Future<void> saveBasicDetails() async {
    await updateProfileStep(1, {
      'age': agelCtrl.value.text.trim(),
      'dob': doblCtrl.value.text.trim(),
      'mobileNo': mobileNumber.value.text.trim(),
      'gender': selectedGender.value,
    });
    Get.toNamed(AppRoutes.religionDetails);
  }

  Future<void> saveReligionDetails() async {
    await updateProfileStep(2, {
      'religion': selectedReligion.value,
      'caste': casteCtrl.value.text.trim(),
      'subCaste': subCasteCtrl.value.text.trim(),
      'willingToMarryOtherCaste': willingToMarryOtherCaste.value,
    });
    Get.toNamed(AppRoutes.personalDetails);
  }

  Future<void> savePersonalDetails() async {
    await updateProfileStep(3, {
      'maritalStatus': maritalStatus.value,
      'numberOfChildren': numberOfChildren.value,
      'isChildrenLivingWithYou': isChildrenLivingWithYou.value,
      'height': height.value,
      'familyStatus': familyStatus.value,
      'familyType': familyType.value,
      'familyValues': familyValueslCtrl.value.text.trim(),
      'anyDisability': anyDisability.value,
    });
    Get.toNamed(AppRoutes.professionalDetails);
  }

  Future<void> saveProfessionalDetails() async {
    await updateProfileStep(4, {
      'education': education.value,
      'employedIn': employedIn.value,
      'occupation': occupation.value,
      'annualIncome': annualIncome.value,
      'workLocation': workLocation.value,
      'state': selectedState.value,
      'city': selectedCity.value,
    });
    Get.toNamed(AppRoutes.aboutYourself);
  }

  // Future<bool> saveAboutYourself() async {
  //   if (!await checkConnection(
  //     statusController: rxRequestStatus,
  //     errorController: errorMessage,
  //   )) {
  //     return true;
  //   }

  //   try {
  //     loading.value = true;
  //     setRxRequestStatus(Status.LOADING);

  //     final user = FirebaseAuth.instance.currentUser;
  //     if (user == null) throw Exception("User not logged in");

  //     // ✅ Convert picked images to Base64
  //     List<String> base64Images = [];
  //     for (int i = 0; i < pickedImages.length; i++) {
  //       final base64Image = await firebaseServices.convertImageToBase64(
  //         pickedImages[i],
  //       );
  //       base64Images.add(base64Image);
  //     }

  //     // ✅ Save only profileImages in Realtime DB
  //     await firebaseServices.saveToRealtimeDB(
  //       path: "users/${user.uid}/profileImages",
  //       data: base64Images,
  //     );

  //     // ✅ Save about yourself + meta data in Firestore
  //     await firebaseServices.updateDataToFirestore(
  //       collection: AppCollections.users,
  //       id: user.uid,
  //       data: {
  //         "aboutYourself": aboutYourselflCtrl.value.text.trim(),
  //         "profileStep": 5,
  //         "profileCompletion": 100,
  //         "profileImages": base64Images,
  //         "updatedAt": FieldValue.serverTimestamp(),
  //       },
  //     );

  //     Utils.snackBar("Success", "Profile completed!", AppColors.green);
  //     setRxRequestStatus(Status.COMPLETED);
  //     clearController();
  //     return true;
  //   } catch (e) {
  //     errorMessage.value = e.toString();
  //     log("Error : $e");
  //     setRxRequestStatus(Status.ERROR);
  //     Utils.snackBar("Error", e.toString(), AppColors.red);
  //     return false;
  //   } finally {
  //     loading.value = false;
  //   }
  // }

  Future<bool> saveAboutYourself() async {
    if (!await checkConnection(
      statusController: rxRequestStatus,
      errorController: errorMessage,
    )) {
      return true;
    }

    try {
      loading.value = true;
      setRxRequestStatus(Status.LOADING);

      final user = FirebaseAuth.instance.currentUser;
      if (user == null) throw Exception("User not logged in");

      // ✅ Upload multiple images to Firebase Storage
      List<String> imageUrls = [];
      for (int i = 0; i < pickedImages.length; i++) {
        final url = await firebaseServices.uploadProfileImage(
          "${user.uid}_$i",
          pickedImages[i],
        );
        imageUrls.add(url);
      }

      // ✅ Save step 5 data + image URLs in Firestore
      await firebaseServices.updateDataToFirestore(
        collection: AppCollections.users,
        id: user.uid,
        data: {
          'profileStep': 5,
          'profileCompletion': 100,
          'aboutYourself': aboutYourselflCtrl.value.text.trim(),
          'profileImages': imageUrls,
          'updatedAt': FieldValue.serverTimestamp(),
        },
      );
      final userData = await firebaseServices.getUserData(uid: user.uid);
      if (userData != null) {
        await AppStorage.storeLocalUser(AppKeys.userData, userData.toJson());
      }
      Utils.snackBar("Success", "Profile completed!", AppColors.green);
      setRxRequestStatus(Status.COMPLETED);
      clearController();
      return true;
    } catch (e) {
      errorMessage.value = e.toString();
      setRxRequestStatus(Status.ERROR);
      Utils.snackBar("Error", e.toString(), AppColors.red);
      return false;
    } finally {
      loading.value = false;
    }
  }

  /// --- Login  --- ///
  Future<void> login() async {
    if (!await checkConnection(
      statusController: rxRequestStatus,
      errorController: errorMessage,
    )) {
      return;
    }
    try {
      loading.value = true;
      setRxRequestStatus(Status.LOADING);

      final id = await firebaseServices.signInWithEmailAndPassword(
        email: loginUserEmail.value.text.trim(),
        password: loginPassword.value.text.trim(),
      );

      if (id == null) {
        Utils.snackBar(
          "Login Failed",
          "Invalid email or password.",
          AppColors.red,
        );
        setRxRequestStatus(Status.ERROR);
        return;
      }

      final user = await firebaseServices.getUserData(uid: id);

      if (user != null) {
        await AppStorage.storeLocalUser(AppKeys.userData, user.toJson());
        log("User : ${user.id}");
        await AppStorage.setUserID(user.id);
        await AppStorage.set('email', loginUserEmail.value.text.trim());
        await AppStorage.set('password', loginPassword.value.text.trim());
        await firebaseServices.setUserStatus(user.id!, "online");

        Utils.snackBar("Success", "Welcome, ${user.email}!", AppColors.green);
        Get.offAllNamed(AppRoutes.dashboardScreen);
        clearController();
        setRxRequestStatus(Status.COMPLETED);
      } else {
        Utils.snackBar("Error", "User data not found.", AppColors.red);
        setRxRequestStatus(Status.ERROR);
      }
    } catch (error) {
      debugPrint(error.toString());
      loading.value = false;
      setRxRequestStatus(Status.ERROR);
      errorMessage.value = error.toString();
      Utils.snackBar("Error", error.toString(), AppColors.red);
    } finally {
      loading.value = false;
    }
  }

  /// --- Logout  --- ///
  Future<void> logout() async {
    if (!await checkConnection(
      statusController: rxRequestStatus,
      errorController: errorMessage,
    )) {
      return;
    }
    try {
      final currentUserId = FirebaseAuth.instance.currentUser?.uid;
      if (currentUserId != null) {
        await firebaseServices.setUserStatus(currentUserId, "offline");
      }
      await firebaseServices.logoutUser();
      await AppStorage.clearSharedData();
      Get.offAllNamed(AppRoutes.loginScreen);
      Utils.snackBar(
        "Logged Out",
        "You have successfully logged out.",
        AppColors.green,
      );
    } catch (error) {
      Utils.snackBar("Error", error.toString(), AppColors.red);
    }
  }

  /// --- Clear Fields  ---
  void clearController() {
    loginUserEmail.value.clear();
    loginPassword.value.clear();

    /// --- Clear Register Fields ---
    fullName.value.clear();
    mobileNumber.value.clear();
    registerPassword.value.clear();
    agelCtrl.value.clear();
    doblCtrl.value.clear();
    emailCtrl.value.clear();
    familyValueslCtrl.value.clear();
    aboutYourselflCtrl.value.clear();
    casteCtrl.value.clear();
    subCasteCtrl.value.clear();

    // Reset selections
    selectedGender.value = '';
    maritalStatus.value = '';
    numberOfChildren.value = '';
    isChildrenLivingWithYou.value = '';
    height.value = '';
    familyStatus.value = '';
    familyType.value = '';
    anyDisability.value = '';
    selectedReligion.value = '';
    selectedCaste.value = '';
    selectedSubCaste.value = '';
    willingToMarryOtherCaste.value = false;
    education.value = '';
    employedIn.value = '';
    occupation.value = '';
    annualIncome.value = '';
    workLocation.value = '';
    selectedState.value = '';
    selectedCity.value = '';
    pickedImages.clear();

    update();
  }
}
