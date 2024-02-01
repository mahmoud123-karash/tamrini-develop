import 'package:cloud_firestore/cloud_firestore.dart';

class SubscriptionModel {
  final String gymId;
  final Timestamp subDate;
  final Timestamp endDate;
  final String uid;
  final num price;
  final String paymentMethod;

  SubscriptionModel({
    required this.gymId,
    required this.subDate,
    required this.endDate,
    required this.uid,
    required this.price,
    required this.paymentMethod,
  });

  factory SubscriptionModel.fromJson(Map<String, dynamic> json) =>
      SubscriptionModel(
        gymId: json['gymId'] ?? "",
        subDate: json['subDate'] ?? Timestamp.now(),
        endDate: json['endDate'] ?? Timestamp.now(),
        uid: json['uid'] ?? '',
        paymentMethod: json['paymentMethod'] ?? 'Zain Cash',
        price: json['price'] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        'gymId': gymId,
        "subDate": subDate,
        "endDate": endDate,
        "uid": uid,
        "price": price,
        "paymentMethod": paymentMethod,
      };
}
