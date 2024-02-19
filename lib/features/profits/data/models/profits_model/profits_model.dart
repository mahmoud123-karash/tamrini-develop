import 'package:cloud_firestore/cloud_firestore.dart';

class ProfitsModel {
  final String userId;
  final String userType;
  final String status;
  final String uid;
  final num amount;
  final Timestamp requestedAt;
  final String requestuid;

  ProfitsModel({
    required this.userId,
    required this.uid,
    required this.status,
    required this.userType,
    required this.amount,
    required this.requestedAt,
    required this.requestuid,
  });

  factory ProfitsModel.fromJson(Map<String, dynamic> json) => ProfitsModel(
        userId: json['userId'] ?? '',
        userType: json['userType'] ?? '',
        status: json['status'] ?? '',
        uid: json['uid'] ?? '',
        requestuid: json['requestuid'] ?? '',
        amount: json['amount'] ?? 0,
        requestedAt: json['requestedAt'] ?? Timestamp.now(),
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "userType": userType,
        "uid": uid,
        "status": status,
        "amount": amount,
        "requestedAt": requestedAt,
        "requestuid": requestuid,
      };
}
