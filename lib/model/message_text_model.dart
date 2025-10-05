import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMessage {
  final String message;
  final String senderId;
  final String receiverId;
  final DateTime? timestamp;
  final bool isRead;

  ChatMessage({
    required this.message,
    required this.senderId,
    required this.receiverId,
    this.timestamp,
    required this.isRead,
  });

  factory ChatMessage.fromMap(Map<String, dynamic> map) {
    return ChatMessage(
      message: map['text'] ?? '',
      senderId: map['senderId'] ?? '',
      receiverId: map['receiverId'] ?? '',
      timestamp: (map['timestamp'] as Timestamp?)?.toDate(),
      isRead: map['isRead'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'text': message,
      'senderId': senderId,
      'receiverId': receiverId,
      'timestamp': timestamp ?? FieldValue.serverTimestamp(),
      "isRead": isRead,
    };
  }
}
