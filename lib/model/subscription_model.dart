import 'package:cloud_firestore/cloud_firestore.dart';

class SubscriptionModel {
  final String planName;
  final double amount;
  final DateTime startDate;
  final DateTime endDate;
  final bool isActive;

  SubscriptionModel({
    required this.planName,
    required this.amount,
    required this.startDate,
    required this.endDate,
    required this.isActive,
  });

  Map<String, dynamic> toJson() => {
    'planName': planName,
    'amount': amount,
    'startDate': startDate,
    'endDate': endDate,
    'isActive': isActive,
  };

  factory SubscriptionModel.fromJson(Map<String, dynamic> json) =>
      SubscriptionModel(
        planName: json['planName'] ?? '',
        amount: (json['amount'] ?? 0).toDouble(),
        startDate: (json['startDate'] as Timestamp).toDate(),
        endDate: (json['endDate'] as Timestamp).toDate(),
        isActive: json['isActive'] ?? false,
      );
}
