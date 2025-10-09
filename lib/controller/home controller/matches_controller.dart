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

  RxInt selectedTab = 0.obs;

  void selectTab(int index) {
    selectedTab.value = index;
  }

  void toggleFilter(String key, bool? value) {
    if (value != null) {
      matchFilters[key] = value;
    }
  }

  RxList<String> tabs =
      [
        // 'Match Preferences',
        'Basic Details',
        'Religious Details',
        'Professional Details',
        'Location Details',
        'Family Details',
      ].obs;

  final RxList<TabItems> tableTabs =
      [
        TabItems(
          // image: 'assets/svg/filters.svg',
          text: 'Filters',
        ),
        // TabItems(text: 'Match Preference'),
        TabItems(text: 'Basic Details'),
        TabItems(text: 'Religious Details'),
        TabItems(text: 'Professional Details'),
        TabItems(text: 'Location Details'),
        TabItems(text: 'Family Details'),
      ].obs;
  // Match Preferences
  RxMap<String, bool> matchFilters =
      <String, bool>{
        "All Matches": false,
        "Newly Joined": false,
        "Viewed You": false,
        "Shortlisted You": false,
        "Viewed By You": false,
        "Shortlisted By You": false,
        "Sent Request": false,
        "Receive Request": false,
        "Accepted Request": false,
      }.obs;

  // Basic Details
  Rx<RangeValues> ageRange = RangeValues(18, 60).obs;
  RxSet<String> selectedHeights = <String>{}.obs;

  void updateAgeRange(RangeValues values) {
    ageRange.value = values;
    applyFilters();
  }

  void toggleSelection(String label) {
    if (selectedHeights.contains(label)) {
      selectedHeights.remove(label);
    } else {
      selectedHeights.add(label);
    }
    applyFilters();
  }

  RxString profileInterested = ''.obs;

  final searchController = TextEditingController();
  RxString searchQuery = ''.obs;
  // Basic Details
  final TextEditingController dob = TextEditingController();
  final TextEditingController age = TextEditingController();
  final TextEditingController motherTongue = TextEditingController();
  final TextEditingController eatingHabits = TextEditingController();
  final TextEditingController smokingHabits = TextEditingController();
  final TextEditingController drinkingHabits = TextEditingController();
  // final TextEditingController profileCreatedBy = TextEditingController();
  final TextEditingController maritalStatus = TextEditingController();
  final TextEditingController livesIn = TextEditingController();
  // final TextEditingController citizen = TextEditingController();

  // Religion Details
  final TextEditingController religion = TextEditingController();
  final TextEditingController caste = TextEditingController();
  final TextEditingController subCaste = TextEditingController();
  // final TextEditingController dosham = TextEditingController();

  // Professional Details
  final TextEditingController employment = TextEditingController();
  final TextEditingController annualIncome = TextEditingController();

  // Educational Details
  final TextEditingController education = TextEditingController();
  final TextEditingController occupation = TextEditingController();
  final TextEditingController workLocation = TextEditingController();
  final TextEditingController state = TextEditingController();
  final TextEditingController city = TextEditingController();

  // Family Details
  final TextEditingController familyType = TextEditingController();
  final TextEditingController familyStatus = TextEditingController();
  // final TextEditingController parents = TextEditingController();
  final TextEditingController noOfChildren = TextEditingController();
  final TextEditingController height = TextEditingController();

  /// --- User Model  --- ///
  Rx<List<UserModel>> usersData = Rx<List<UserModel>>([]);
  Rx<List<UserModel>> filteredUsers = Rx<List<UserModel>>([]);
  Rx<UserModel?> matchDetails = Rx<UserModel?>(null);
  //  RxList<UserModel> usersData = <UserModel>[].obs;
  // RxList<UserModel> filteredUsers = <UserModel>[].obs;

  // ✅ Main filtering function
  void applyFilters() {
    List<UserModel> allUsers = usersData.value;
    List<UserModel> filtered = allUsers;

    final selectedList = selectedHeights.toList();
    final ageRangeSelected = ageRange.value;

    // 🟢 BASIC DETAILS
    if (selectedList.contains('Male') || selectedList.contains('Female')) {
      filtered =
          filtered
              .where((user) => selectedList.contains(user.gender ?? ''))
              .toList();
    }

    final maritalStatusOptions = ['Married', 'Unmarried', 'Divorced'];
    final selectedMarital =
        selectedList.where(maritalStatusOptions.contains).toList();
    if (selectedMarital.isNotEmpty) {
      filtered =
          filtered
              .where(
                (user) => selectedMarital.contains(user.maritalStatus ?? ''),
              )
              .toList();
    }

    filtered =
        filtered.where((user) {
          final age = int.tryParse(user.age ?? '');
          if (age == null) return false;
          return age >= ageRangeSelected.start && age <= ageRangeSelected.end;
        }).toList();

    // 🟢 RELIGIOUS DETAILS
    final religions = [
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
    final selectedReligions =
        selectedList.where((item) => religions.contains(item)).toList();
    if (selectedReligions.isNotEmpty) {
      filtered =
          filtered
              .where((user) => selectedReligions.contains(user.religion ?? ''))
              .toList();
    }

    // Children filters
    final childrenOptions = ['0', '1', '2', '3', '4', '5'];
    final selectedChildren =
        selectedList.where((item) => childrenOptions.contains(item)).toList();
    if (selectedChildren.isNotEmpty) {
      filtered =
          filtered
              .where(
                (user) =>
                    selectedChildren.contains(user.numberOfChildren ?? ''),
              )
              .toList();
    }

    if (selectedList.contains('Yes') || selectedList.contains('No')) {
      filtered =
          filtered
              .where(
                (user) =>
                    selectedList.contains(user.isChildrenLivingWithYou ?? ''),
              )
              .toList();
    }

    // 🟢 PROFESSIONAL DETAILS
    final educationLevels = [
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
    final selectedEdu =
        selectedList.where((item) => educationLevels.contains(item)).toList();
    if (selectedEdu.isNotEmpty) {
      filtered =
          filtered
              .where((user) => selectedEdu.contains(user.education ?? ''))
              .toList();
    }

    final employedInOptions = [
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
    final selectedEmp =
        selectedList.where((item) => employedInOptions.contains(item)).toList();
    if (selectedEmp.isNotEmpty) {
      filtered =
          filtered
              .where((user) => selectedEmp.contains(user.employedIn ?? ''))
              .toList();
    }

    final occupationOptions = [
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
    final selectedOcc =
        selectedList.where((item) => occupationOptions.contains(item)).toList();
    if (selectedOcc.isNotEmpty) {
      filtered =
          filtered
              .where((user) => selectedOcc.contains(user.occupation ?? ''))
              .toList();
    }

    final incomeOptions = [
      'Less than 1 Lakh',
      '1 - 3 Lakh',
      '3 - 5 Lakh',
      '5 - 10 Lakh',
      '10 - 20 Lakh',
      '20+ Lakh',
    ];
    final selectedIncome =
        selectedList.where((item) => incomeOptions.contains(item)).toList();
    if (selectedIncome.isNotEmpty) {
      filtered =
          filtered
              .where((user) => selectedIncome.contains(user.annualIncome ?? ''))
              .toList();
    }

    // 🟢 LOCATION DETAILS
    final workLocationOptions = ['Remote', 'On-site', 'Hybrid'];
    final selectedWorkLocation =
        selectedList.where(workLocationOptions.contains).toList();
    if (selectedWorkLocation.isNotEmpty) {
      filtered =
          filtered
              .where(
                (user) =>
                    selectedWorkLocation.contains(user.workLocation ?? ''),
              )
              .toList();
    }

    // 🟢 FAMILY DETAILS
    final familyStatus = ['Middle Class', 'Upper Class', 'Rich', 'Normal'];
    final selectedFamilyStatus =
        selectedList.where(familyStatus.contains).toList();
    if (selectedFamilyStatus.isNotEmpty) {
      filtered =
          filtered
              .where(
                (user) =>
                    selectedFamilyStatus.contains(user.familyStatus ?? ''),
              )
              .toList();
    }

    final familyType = ['Joint', 'Nuclear'];
    final selectedFamilyType = selectedList.where(familyType.contains).toList();
    if (selectedFamilyType.isNotEmpty) {
      filtered =
          filtered
              .where(
                (user) => selectedFamilyType.contains(user.familyType ?? ''),
              )
              .toList();
    }
    final familyValue = [
      '0',
      '1',
      '2',
      '3',
      '4',
      '5',
      '6',
      '7',
      '8',
      '9',
      '20',
    ];
    final selectedfamilyValue =
        selectedList.where(familyValue.contains).toList();
    if (selectedfamilyValue.isNotEmpty) {
      filtered =
          filtered
              .where(
                (user) => selectedfamilyValue.contains(user.familyValues ?? ''),
              )
              .toList();
    }

    // ✅ Final result
    filteredUsers.value = filtered;
  }

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
        filteredUsers.value = users;
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

  // --- Add this new function ---
  void searchUsers(String query) {
    searchQuery.value = query.trim();

    if (query.isEmpty) {
      // 🔄 Reset search: show all filtered users from filters
      applyFilters();
      return;
    }

    final lowerQuery = query.toLowerCase();
    List<UserModel> allUsers = usersData.value;
    List<UserModel> filtered =
        allUsers
            .where(
              (user) => (user.name ?? '').toLowerCase().contains(lowerQuery),
            )
            .toList();

    filteredUsers.value = filtered;
  }
}
