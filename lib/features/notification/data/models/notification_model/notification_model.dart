import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
  final String title;
  final String body;
  final String senderUid;
  final String type;
  final String uid;
  final String notificationUid;
  final String promotionType;
  final Timestamp time;
  late bool isReaden;

  NotificationModel({
    required this.notificationUid,
    required this.isReaden,
    required this.promotionType,
    required this.senderUid,
    required this.title,
    required this.body,
    required this.type,
    required this.uid,
    required this.time,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json, String id) =>
      NotificationModel(
        title: json['title'] ?? '',
        senderUid: json['senderUid'] ?? '',
        body: json['body'] ?? '',
        type: json['type'] ?? '',
        uid: json['uid'] ?? '',
        time: json['time'] ?? Timestamp.now(),
        promotionType: json['promotionType'] ?? '',
        notificationUid: id,
        isReaden: json['isReaden'] ?? false,
      );
}
