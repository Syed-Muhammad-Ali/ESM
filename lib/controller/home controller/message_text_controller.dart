import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:european_single_marriage/core/utils/constant/app_collections.dart';
import 'package:european_single_marriage/core/utils/constant/app_colors.dart';
import 'package:european_single_marriage/core/utils/snackBar/snackbar_utils.dart';
import 'package:european_single_marriage/data/storage/app_storage.dart';
import 'package:european_single_marriage/model/message_text_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MessageController extends GetxController {
  final scrollController = ScrollController();
  TextEditingController chatTypeController = TextEditingController();
  final currentText = ''.obs;

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

  /// ✅ Create a unique chatId for both users
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
    final timestamp = FieldValue.serverTimestamp();

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

    // ✅ Check if inbox exists; create if missing
    final senderInboxSnapshot = await senderInboxRef.get();
    if (!senderInboxSnapshot.exists) {
      await makeInbox(id: receiverId, name: receiverName, image: receiverImage);
    }

    final receiverInboxSnapshot = await receiverInboxRef.get();
    if (!receiverInboxSnapshot.exists) {
      await makeSingleInbox(
        chatId: chatId,
        id: receiverId,
        name: receiverName,
        image: receiverImage,
      );
    }

    // ✅ Message model
    final message = {
      'text': text,
      'senderId': senderId,
      'receiverId': receiverId,
      'senderName': AppStorage.userData.value.name,
      'senderImage': AppStorage.userData.value.userProfilePic,
      'timestamp': timestamp,
      'isRead': false,
    };

    // ✅ Write message in ONE place (sender inbox)
    await senderInboxRef.collection('messages').add(message);

    // ✅ Update sender inbox (no unread count for sender)
    await senderInboxRef.set({
      'peerId': receiverId,
      'peerName': receiverName,
      'peerImage': receiverImage,
      'chatId': chatId,
      'last_message': text,
      'last_message_time': timestamp,
      'unread_count': 0,
      'isRead': true,
    }, SetOptions(merge: true));

    // ✅ Update receiver inbox (increment unread count)
    await receiverInboxRef.set({
      'peerId': senderId,
      'peerName': AppStorage.userData.value.name,
      'peerImage': AppStorage.userData.value.userProfilePic,
      'chatId': chatId,
      'last_message': text,
      'last_message_time': timestamp,
      'unread_count': FieldValue.increment(1),
      'isRead': false,
    }, SetOptions(merge: true));

    // ✅ Clear message input + scroll
    chatTypeController.clear();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.jumpTo(scrollController.position.maxScrollExtent);
      }
    });
  }

  /// ✅ Create sender + receiver inbox (initial)
  Future<void> makeInbox({
    required String id,
    required String name,
    required String image,
  }) async {
    try {
      final senderId = FirebaseAuth.instance.currentUser!.uid;

      // ✅ Log who is chatting with whom
      log("🟢 Creating inbox between:");
      log("   Sender ID : $senderId");
      log("   Receiver ID : $id");
      log("   Receiver Name : $name");

      if (id.isEmpty || senderId.isEmpty) {
        log("❌ Error: One of the user IDs is empty!");
        Utils.snackBar("Error", "Invalid user data!", AppColors.red);
        return;
      }

      // ✅ Create chatId
      final String chatId = await createUniqueId(
        senderId: senderId,
        receiverId: id,
      );

      log("📦 Generated Chat ID: $chatId");

      // ✅ Sender Inbox
      await FirebaseFirestore.instance
          .collection(AppCollections.users)
          .doc(senderId)
          .collection(AppCollections.inbox)
          .doc(chatId)
          .set({
            "peerId": id,
            "peerName": name,
            "peerImage": image,
            "chatId": chatId,
            "unread_count": 0,
            "last_message": null,
            "last_message_time": null,
          });

      log("✅ Sender inbox created successfully.");

      // ✅ Receiver Inbox
      final receiverName = AppStorage.userData.value.name;
      final receiverImage = AppStorage.userData.value.userProfilePic;

      log("🟡 Creating receiver inbox for $receiverName");

      await FirebaseFirestore.instance
          .collection(AppCollections.users)
          .doc(id)
          .collection(AppCollections.inbox)
          .doc(chatId)
          .set({
            "peerId": senderId,
            "peerName": receiverName,
            "peerImage": receiverImage,
            "chatId": chatId,
            "unread_count": FieldValue.increment(1),
            "last_message": null,
            "last_message_time": null,
          });

      log("✅ Receiver inbox created successfully.");
    } catch (e, stack) {
      log("🔥 Error in makeInbox(): $e");
      log("Stack trace: $stack");
      Utils.snackBar("Error", "Failed to create chat inbox!", AppColors.red);
    }
  }

  Future<void> makeSingleInbox({
    required String chatId,
    required String id,
    required String name,
    required String image,
  }) async {
    try {
      final senderId = FirebaseAuth.instance.currentUser!.uid;

      log("🟢 makeSingleInbox() called");
      log("   Sender ID   : $senderId");
      log("   Receiver ID : $id");
      log("   Chat ID     : $chatId");
      log("   Receiver Name : $name");

      // ✅ Validate all required values
      if (chatId.isEmpty || id.isEmpty || senderId.isEmpty) {
        log("❌ Error: One or more required fields are empty!");
        Utils.snackBar("Error", "Invalid chat or user data!", AppColors.red);
        return;
      }

      final senderName = AppStorage.userData.value.name;
      final senderImage = AppStorage.userData.value.userProfilePic;

      log("🟡 Creating single inbox for receiver $name ($id)");

      await FirebaseFirestore.instance
          .collection(AppCollections.users)
          .doc(id)
          .collection(AppCollections.inbox)
          .doc(chatId)
          .set({
            "peerId": senderId,
            "peerName": senderName,
            "peerImage": senderImage,
            "chatId": chatId,
            "unread_count": FieldValue.increment(1),
            "last_message": null,
            "last_message_time": null,
          });

      log("✅ makeSingleInbox() completed successfully for $name");
    } catch (e, stack) {
      log("🔥 Error in makeSingleInbox(): $e");
      log("Stack trace: $stack");
      Utils.snackBar(
        "Error",
        "Failed to create receiver inbox!",
        AppColors.red,
      );
    }
  }

  /// ---Get Messages Stream--- ///
  Stream<List<ChatMessage>> getMessages(String chatId) {
    final userId = FirebaseAuth.instance.currentUser!.uid;

    return FirebaseFirestore.instance
        .collection(AppCollections.users)
        .doc(userId)
        .collection(AppCollections.inbox)
        .doc(chatId)
        .collection(AppCollections.messages)
        .orderBy('timestamp', descending: false)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs
                  .map((doc) => ChatMessage.fromMap(doc.data()))
                  .toList(),
        );
  }

  /// --- Mark Message Read --- ///
  Future<void> markMessagesAsRead(String chatId, String receiverId) async {
    final userId = FirebaseAuth.instance.currentUser!.uid;

    final inboxRef = FirebaseFirestore.instance
        .collection(AppCollections.users)
        .doc(userId)
        .collection(AppCollections.inbox)
        .doc(chatId);

    final messagesRef = inboxRef.collection(AppCollections.messages);

    final unreadMessages =
        await messagesRef.where("isRead", isEqualTo: false).get();

    for (var doc in unreadMessages.docs) {
      await doc.reference.update({"isRead": true});
    }

    // ✅ reset unread count and mark inbox as read
    await inboxRef.set({
      "unread_count": 0,
      "isRead": true,
    }, SetOptions(merge: true));

    // ✅ also update sender’s inbox (so sender sees ✓✓)
    final receiverInboxRef = FirebaseFirestore.instance
        .collection(AppCollections.users)
        .doc(receiverId)
        .collection(AppCollections.inbox)
        .doc(chatId);

    await receiverInboxRef.set({"isRead": true}, SetOptions(merge: true));
  }
}
