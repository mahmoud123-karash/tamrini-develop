import 'package:cloud_firestore/cloud_firestore.dart';

class AnswerModel {
  final Timestamp date;
  final String answer;
  final String userUid;

  AnswerModel({
    required this.date,
    required this.answer,
    required this.userUid,
  });

  factory AnswerModel.fromJson(Map<String, dynamic> json) {
    return AnswerModel(
      date: json['date'] ?? Timestamp.now(),
      answer: json['answer'] ?? '',
      userUid: json['userUid'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['answer'] = answer;
    data['userUid'] = userUid;
    return data;
  }
}
