import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:european_single_marriage/core/utils/constant/app_collections.dart';
import 'package:european_single_marriage/data/response/status.dart';
import 'package:european_single_marriage/model/chat_model.dart';
import 'package:european_single_marriage/services/firebase_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  final rxRequestStatus = Status.LOADING.obs;
  final errorMessage = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  final FirebaseService firebaseServices = Get.find<FirebaseService>();

  RxInt selectedIndex = 0.obs;
  RxList<String> tabs = ["All Messages", "Unread Messages", "Calls"].obs;

  Stream<List<ChatModel>> fetchInboxStream() {
    final userId = FirebaseAuth.instance.currentUser!.uid;

    return FirebaseFirestore.instance
        .collection(AppCollections.users)
        .doc(userId)
        .collection(AppCollections.inbox)
        .orderBy('last_message_time', descending: true)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((doc) => ChatModel.fromFirestore(doc)).toList(),
        );
  }
}
