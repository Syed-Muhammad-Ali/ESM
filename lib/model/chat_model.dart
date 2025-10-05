import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatModel {
  final String chatId;
  final String name;
  final String message;
  final String time;
  final String image;
  // final bool isOnline;
  final int unreadCount;
  final bool isRead; // ✅ for double tick

  ChatModel({
    required this.chatId,
    required this.name,
    required this.message,
    required this.time,
    required this.image,
    // this.isOnline = false,
    this.unreadCount = 0,
    this.isRead = false,
  });

  factory ChatModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ChatModel(
      chatId: data['chatId'] ?? '',
      name: data['peerName'] ?? '',
      message: data['last_message'] ?? '',
      time:
          data['last_message_time'] != null
              ? _formatTime((data['last_message_time'] as Timestamp).toDate())
              : '',
      image: data['peerImage'] ?? '',
      unreadCount: data['unread_count'] ?? 0,
      isRead: data['isRead'] ?? false,
    );
  }

  static String _formatTime(DateTime? date) {
    if (date == null) return "";
    final timeOfDay = TimeOfDay.fromDateTime(date);
    return timeOfDay.format(Get.context!);
  }

  // static String _formatTime(DateTime date) {
  //   final now = DateTime.now();
  //   if (now.difference(date).inDays == 0) {
  //     return "${date.hour}:${date.minute.toString().padLeft(2, '0')}";
  //   } else {
  //     return "${date.day}/${date.month}";
  //   }
  // }
}
