import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tamrini/core/models/user_model/user_model.dart';

class PromotionModel {
  final String uid;
  final String userId;
  final String promotionType;
  final Timestamp requestTime;
  UserModel? user;

  PromotionModel({
    required this.uid,
    required this.userId,
    required this.promotionType,
    required this.requestTime,
    this.user,
  });

  factory PromotionModel.fromJson(Map<String, dynamic> json, user) {
    return PromotionModel(
      uid: json['uid'] ?? '',
      userId: json['userId'] ?? '',
      promotionType: json['promotionType'] ?? '',
      requestTime: json['requestTime'] ?? Timestamp.now(),
      user: user,
    );
  }

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "promotionType": promotionType,
        "requestTime": requestTime,
        "uid": uid,
      };
}
