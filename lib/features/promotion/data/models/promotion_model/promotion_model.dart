import 'package:cloud_firestore/cloud_firestore.dart';

class PromotionModel {
  final String uid;
  final String userId;
  final String promotionType;
  final Timestamp requestTime;

  PromotionModel({
    required this.uid,
    required this.userId,
    required this.promotionType,
    required this.requestTime,
  });

  factory PromotionModel.fromJson(Map<String, dynamic> json) {
    return PromotionModel(
      uid: json['uid'] ?? '',
      userId: json['userId'] ?? '',
      promotionType: json['promotionType'] ?? '',
      requestTime: json['requestTime'] ?? Timestamp.now(),
    );
  }

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "promotionType": promotionType,
        "requestTime": requestTime,
      };
}
