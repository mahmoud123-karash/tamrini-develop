import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tamrini/core/models/user_model/user_model.dart';

class NotificationModel {
  final String title;
  final String body;
  final String senderUid;
  final String type;
  final String uid;
  final String notificationUid;
  final String subType;
  final Timestamp time;
  late bool isReaden;
  final UserModel user;

  NotificationModel({
    required this.notificationUid,
    required this.isReaden,
    required this.subType,
    required this.senderUid,
    required this.title,
    required this.body,
    required this.type,
    required this.uid,
    required this.time,
    required this.user,
  });

  factory NotificationModel.fromJson(
          Map<String, dynamic> json, String id, UserModel user) =>
      NotificationModel(
        title: json['title'] ?? '',
        senderUid: json['senderUid'] ?? '',
        body: json['body'] ?? '',
        type: json['type'] ?? '',
        uid: json['uid'] ?? '',
        time: json['time'] ?? Timestamp.now(),
        subType: json['subType'] ?? '',
        notificationUid: id,
        isReaden: json['isReaden'] ?? false,
        user: user,
      );
}
