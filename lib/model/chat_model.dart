// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatModel {
  final String chatId;
  final String peerId;
  final String peerName;
  final String lastMessage;
  final String last_message_time;
  final String peerImage;
  // final bool isOnline;
  final int unreadCount;
  final bool isRead;

  ChatModel({
    required this.chatId,
    required this.peerId,
    required this.peerName,
    required this.lastMessage,
    required this.last_message_time,
    required this.peerImage,
    // this.isOnline = false,
    this.unreadCount = 0,
    this.isRead = false,
  });

  factory ChatModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ChatModel(
      chatId: data['chatId'] ?? '',
      peerId: data['peerId'] ?? '',
      peerName: data['peerName'] ?? '',
      lastMessage: data['last_message'] ?? '',
      last_message_time:
          data['last_message_time'] != null
              ? _formatTime((data['last_message_time'] as Timestamp).toDate())
              : '',
      peerImage: data['peerImage'] ?? '',
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
