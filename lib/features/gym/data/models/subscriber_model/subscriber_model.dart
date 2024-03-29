import 'package:cloud_firestore/cloud_firestore.dart';

class SubscriberModel {
  final String userId;
  final Timestamp subDate;
  final Timestamp endDate;
  final String uid;
  final num price;
  final String paymentMethod;

  SubscriberModel({
    required this.userId,
    required this.subDate,
    required this.endDate,
    required this.uid,
    required this.price,
    required this.paymentMethod,
  });

  factory SubscriberModel.fromJson(Map<String, dynamic> json) =>
      SubscriberModel(
        userId: json['userId'] ?? "",
        subDate: json['subDate'] ?? Timestamp.now(),
        endDate: json['endDate'] ?? Timestamp.now(),
        uid: json['uid'] ?? '',
        paymentMethod: json['paymentMethod'] ?? 'Zain Cash',
        price: json['price'] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        'userId': userId,
        "subDate": subDate,
        "endDate": endDate,
        "uid": uid,
        "price": price,
        "paymentMethod": paymentMethod,
      };
}
