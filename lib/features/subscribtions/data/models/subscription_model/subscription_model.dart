import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';

part 'subscription_model.g.dart';

@HiveType(typeId: 8)
class SubscriptionModel {
  @HiveField(0)
  final String gymId;
  @HiveField(1)
  final Timestamp subDate;
  @HiveField(2)
  final Timestamp endDate;
  @HiveField(3)
  final String uid;
  @HiveField(4)
  final num price;
  @HiveField(5)
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
