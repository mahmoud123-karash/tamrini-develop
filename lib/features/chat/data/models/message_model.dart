import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String message;
  final String senderUid;
  final String recieverUid;
  final Timestamp time;
  final String uid;

  MessageModel({
    required this.message,
    required this.senderUid,
    required this.recieverUid,
    required this.time,
    required this.uid,
  });
  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
        message: json['message'] ?? '',
        senderUid: json['senderUid'] ?? '',
        recieverUid: json['recieverUid'] ?? '',
        time: json['time'] ?? Timestamp.now(),
        uid: json['uid'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'message': message,
        'senderUid': senderUid,
        'recieverUid': recieverUid,
        'time': time,
        'uid': uid,
      };
}
