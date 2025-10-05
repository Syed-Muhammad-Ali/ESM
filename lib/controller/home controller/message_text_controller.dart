import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:european_single_marriage/core/utils/constant/app_collections.dart';
import 'package:european_single_marriage/data/storage/app_storage.dart';
import 'package:european_single_marriage/model/message_text_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MessageController extends GetxController {
  final scrollController = ScrollController();
  TextEditingController chatTypeController = TextEditingController();
  final currentText = ''.obs;

  //=============Emojii Code=======================//
  var isemojiVisible = false.obs;
  FocusNode focusNode = FocusNode();

  @override
  void onInit() {
    super.onInit();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        isemojiVisible.value = false;
      }
    });
  }

  @override
  void onClose() {
    chatTypeController.dispose();
  }
  //============End Emojii Code===============//

  /// ---Chat ID Creation --- ///
  Future<String> createUniqueId({
    required String senderId,
    required String receiverId,
  }) async {
    List<String> ids = [senderId, receiverId];
    ids.sort();

    return ids.join('_');
  }

  /// ---Send Message to Firebase--- ///
  Future<void> sendMessage({
    required String receiverId,
    required String receiverName,
    required String receiverImage,
  }) async {
    final text = chatTypeController.text.trim();
    if (text.isEmpty) return;

    final senderId = FirebaseAuth.instance.currentUser!.uid;
    final chatId = await createUniqueId(
      senderId: senderId,
      receiverId: receiverId,
    );

    final message = {
      'text': text,
      'senderId': senderId,
      'receiverId': receiverId,
      'timestamp': FieldValue.serverTimestamp(),
      'isRead': false,
    };

    // Save in sender inbox
    final senderInboxRef = FirebaseFirestore.instance
        .collection(AppCollections.users)
        .doc(senderId)
        .collection(AppCollections.inbox)
        .doc(chatId);

    // Save in receiver inbox
    final receiverInboxRef = FirebaseFirestore.instance
        .collection(AppCollections.users)
        .doc(receiverId)
        .collection(AppCollections.inbox)
        .doc(chatId);

    await Future.wait([
      senderInboxRef.collection('messages').add(message),
      receiverInboxRef.collection('messages').add(message),
    ]);

    final lastMessageUpdate = {
      'last_message': text,
      'last_message_time': FieldValue.serverTimestamp(),
    };

    await Future.wait([
      senderInboxRef.set({
        "peerId": receiverId,
        "peerName": receiverName,
        "peerImage": receiverImage,
        "chatId": chatId,
        // "unread_count": 0,
        ...lastMessageUpdate,
      }, SetOptions(merge: true)),
      receiverInboxRef.set({
        "peerId": senderId,
        "peerName": AppStorage.userData.value.name,
        "peerImage": "", // yahan ap apna user image add karo
        "chatId": chatId,
        // "unread_count": FieldValue.increment(1),
        ...lastMessageUpdate,
      }, SetOptions(merge: true)),
    ]);

    chatTypeController.clear();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
    });
  }

  /// ---Get Messages Stream--- ///
  Stream<List<ChatMessage>> getMessages(String chatId) {
    final senderId = FirebaseAuth.instance.currentUser!.uid;

    return FirebaseFirestore.instance
        .collection(AppCollections.users)
        .doc(senderId)
        .collection(AppCollections.inbox)
        .doc(chatId)
        .collection(AppCollections.messages)
        .orderBy('timestamp', descending: false)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => ChatMessage.fromMap(doc.data()))
              .toList();
        });
  }

  /// --- Mark Message Read --- ///
  Future<void> markMessagesAsRead(String chatId, String receiverId) async {
    final userId = FirebaseAuth.instance.currentUser!.uid;

    final inboxRef = FirebaseFirestore.instance
        .collection(AppCollections.users)
        .doc(userId)
        .collection(AppCollections.inbox)
        .doc(chatId);

    await inboxRef.set({"unread_count": 0}, SetOptions(merge: true));

    final messagesRef = inboxRef.collection(AppCollections.messages);
    final unreadMessages =
        await messagesRef.where("isRead", isEqualTo: false).get();

    for (var doc in unreadMessages.docs) {
      await doc.reference.update({"isRead": true});
    }
  }
}
