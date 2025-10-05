import 'package:european_single_marriage/controller/network_aware_controller.dart';
import 'package:european_single_marriage/core/utils/constant/app_collections.dart';
import 'package:european_single_marriage/core/utils/constant/app_images.dart';
import 'package:european_single_marriage/data/response/status.dart';
import 'package:european_single_marriage/model/home_model.dart';
import 'package:european_single_marriage/model/user_model.dart';
import 'package:european_single_marriage/services/firebase_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class HomeController extends GetxController with NetworkAwareController {
  final rxRequestStatus = Status.LOADING.obs;
  final errorMessage = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  final FirebaseService firebaseServices = Get.find<FirebaseService>();

  /// --- Observables --- ///
  Rx<List<UserModel>> allMatches = Rx<List<UserModel>>([]);
  Rx<List<UserModel>> sameCasteMatches = Rx<List<UserModel>>([]);
  Rx<List<UserModel>> nearLocationMatches = Rx<List<UserModel>>([]);
  Rx<UserModel?> user = Rx<UserModel?>(null);
  Rx<UserModel?> matchDetails = Rx<UserModel?>(null);

  RxString searchQuery = ''.obs;

  /// Get current logged-in user ID and data
  final currentUserId = FirebaseAuth.instance.currentUser?.uid;
  UserModel? currentUser; // Set this after login or from HomeController

  /// ---------------- FETCH ALL USERS ----------------
  Future<void> fetchAllMatches() async {
    try {
      setRxRequestStatus(Status.LOADING);
      errorMessage.value = "";

      final users = await firebaseServices
          .getDataFromFirestore<List<UserModel>>(
            collection: AppCollections.users,
            where: {
              "id": {"notEqual": currentUserId},
            },

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
        allMatches.value = users.take(10).toList();
        setRxRequestStatus(Status.COMPLETED);
      } else {
        allMatches.value = [];
        errorMessage.value = "No matches found!";
        setRxRequestStatus(Status.COMPLETED);
      }
    } catch (error) {
      errorMessage.value = "Failed to fetch users: $error";
      setRxRequestStatus(Status.ERROR);
    }
  }

  /// ---------------- FETCH SAME CASTE ----------------

  Future<void> fetchSameCasteMatches() async {
    if (currentUser == null) return;

    try {
      setRxRequestStatus(Status.LOADING);

      final users = await firebaseServices
          .getDataFromFirestore<List<UserModel>>(
            collection: AppCollections.users,
            where: {
              "caste": currentUser!.caste,
              "id": {"notEqual": currentUserId},
            },
            fromJson:
                (jsonList) =>
                    (jsonList as List)
                        .map(
                          (json) =>
                              UserModel.fromJson(json as Map<String, dynamic>),
                        )
                        .toList(),
          );

      sameCasteMatches.value = users ?? [];
      setRxRequestStatus(Status.COMPLETED);
    } catch (error) {
      errorMessage.value = "Failed to fetch same caste users: $error";
      setRxRequestStatus(Status.ERROR);
    }
  }

  /// ---------------- FETCH SAME CITY ----------------

  Future<void> fetchNearLocationMatches() async {
    if (currentUser == null) return;

    try {
      setRxRequestStatus(Status.LOADING);

      final users = await firebaseServices
          .getDataFromFirestore<List<UserModel>>(
            collection: AppCollections.users,
            where: {
              "city": currentUser!.city,
              "id": {"notEqual": currentUserId},
            },
            fromJson:
                (jsonList) =>
                    (jsonList as List)
                        .map(
                          (json) =>
                              UserModel.fromJson(json as Map<String, dynamic>),
                        )
                        .toList(),
          );

      nearLocationMatches.value = users ?? [];
      setRxRequestStatus(Status.COMPLETED);
    } catch (error) {
      errorMessage.value = "Failed to fetch nearby users: $error";
      setRxRequestStatus(Status.ERROR);
    }
  }

  /// ---------------- SEARCH FUNCTION ----------------
void searchUsers(String query) {
  searchQuery.value = query.trim().toLowerCase();

  // If search field is empty → restore original lists
  if (searchQuery.value.isEmpty) {
    allMatches.refresh();
    sameCasteMatches.refresh();
    nearLocationMatches.refresh();
    return;
  }

  // Local filtering (no Firebase calls)
  final filteredAll = allMatches.value
      .where((u) => (u.name ?? '').toLowerCase().contains(searchQuery.value))
      .toList();

  final filteredSameCaste = sameCasteMatches.value
      .where((u) => (u.name ?? '').toLowerCase().contains(searchQuery.value))
      .toList();

  final filteredNearLocation = nearLocationMatches.value
      .where((u) => (u.name ?? '').toLowerCase().contains(searchQuery.value))
      .toList();

  // Update lists only visually
  allMatches.value = filteredAll;
  sameCasteMatches.value = filteredSameCaste;
  nearLocationMatches.value = filteredNearLocation;
}

  RxInt notifications = 2.obs;
  RxInt profileCompletion = 40.obs;
  final users =
      HomeModel(
        name: "Ijaz",
        imageUrl: AppImages.imageURL,
        viewedYou: 5,
        sentRequests: 5,
        receivedRequests: 5,
        acceptedRequests: 5,
        profileCompletion: 0.4,
      ).obs;
}
