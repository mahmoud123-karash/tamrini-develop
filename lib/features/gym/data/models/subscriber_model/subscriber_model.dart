import 'package:cloud_firestore/cloud_firestore.dart';

class SubscriberModel {
  final String userId;
  final Timestamp subDate;
  final Timestamp endDate;
  final String uid;

  SubscriberModel({
    required this.userId,
    required this.subDate,
    required this.endDate,
    required this.uid,
  });

  factory SubscriberModel.fromJson(Map<String, dynamic> json) =>
      SubscriberModel(
        userId: json['userId'] ?? "",
        subDate: json['subDate'] ?? Timestamp.now(),
        endDate: json['endDate'] ?? Timestamp.now(),
        uid: json['uid'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'userId': userId,
        "subDate": subDate,
        "endDate": endDate,
        "uid": uid,
      };
}
