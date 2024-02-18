import 'package:cloud_firestore/cloud_firestore.dart';

class ProfitsModel {
  final String userId;
  final num profits;
  final Timestamp requestedAt;

  ProfitsModel({
    required this.userId,
    required this.profits,
    required this.requestedAt,
  });

  factory ProfitsModel.fromJson(Map<String, dynamic> json) => ProfitsModel(
        userId: json['userId'] ?? '',
        profits: json['profits'] ?? 0,
        requestedAt: json['requestedAt'] ?? Timestamp.now(),
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "profits": profits,
        "requestedAt": requestedAt,
      };
}
