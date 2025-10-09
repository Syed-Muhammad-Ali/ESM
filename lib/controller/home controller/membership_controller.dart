import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:european_single_marriage/core/utils/constant/app_collections.dart';
import 'package:european_single_marriage/core/utils/constant/app_colors.dart';
import 'package:european_single_marriage/core/utils/snackBar/snackbar_utils.dart';
import 'package:european_single_marriage/model/subscription_model.dart';
import 'package:european_single_marriage/views/app%20screens/dashboard%20screens/add_friend_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class MembershipController extends GetxController {
  Rx<SubscriptionModel?> currentPlan = Rx<SubscriptionModel?>(null);
  RxBool isLoading = false.obs;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    fetchSubscription();
  }

  /// ✅ Fetch user subscription from Firestore
  Future<void> fetchSubscription() async {
    try {
      isLoading.value = true;
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return;

      final doc =
          await _db
              .collection(AppCollections.subscriptions)
              .doc(user.uid)
              .get();
      if (doc.exists) {
        currentPlan.value = SubscriptionModel.fromJson(doc.data()!);
        await _checkAndDeactivateExpired();
      } else {
        currentPlan.value = null;
      }
    } catch (e) {
      Utils.snackBar(
        'Error',
        'Failed to fetch subscription: $e',
        AppColors.red,
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// ✅ Auto deactivate if expired
  Future<void> _checkAndDeactivateExpired() async {
    final plan = currentPlan.value;
    final user = FirebaseAuth.instance.currentUser;
    if (plan == null || user == null) return;

    if (DateTime.now().isAfter(plan.endDate)) {
      await _db.collection(AppCollections.subscriptions).doc(user.uid).update({
        'isActive': false,
      });
      currentPlan.value = null;
    }
  }

  /// ✅ Create new subscription (after Stripe payment success)
  Future<void> createSubscription(double amount, String planName) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return;

      final start = DateTime.now();
      final end = start.add(const Duration(days: 30));

      final sub = SubscriptionModel(
        planName: planName,
        amount: amount,
        startDate: start,
        endDate: end,
        isActive: true,
      );

      await _db
          .collection(AppCollections.subscriptions)
          .doc(user.uid)
          .set(sub.toJson());
      currentPlan.value = sub;

      Utils.snackBar('Success', 'Subscription activated!', AppColors.green);
      Get.to(() => AddFriendPage());
    } catch (e) {
      Utils.snackBar(
        'Error',
        'Failed to create subscription: $e',
        AppColors.red,
      );
    }
  }

  /// ✅ Check if subscription is active
  bool get hasActiveSubscription {
    final plan = currentPlan.value;
    if (plan == null) return false;
    return plan.isActive && DateTime.now().isBefore(plan.endDate);
  }
}
