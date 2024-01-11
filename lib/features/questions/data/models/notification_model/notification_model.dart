import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
  final String title;
  final String body;
  final String senderUid;
  final String type;
  final String uid;
  String? notificationUid;
  String? promotionType;
  final Timestamp time;
  final bool isReaden;

  NotificationModel({
    String? notificationUid,
    required this.isReaden,
    String? promotionType,
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

  Map<String, dynamic> toJson() => {
        "title": title,
        "body": body,
        "uid": uid,
        "time": time,
        "type": type,
        "senderUid": senderUid,
        "promotionType": promotionType,
        "isReaden": isReaden,
      };
}
