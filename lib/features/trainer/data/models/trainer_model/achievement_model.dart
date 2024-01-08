import 'package:cloud_firestore/cloud_firestore.dart';

class AchivevementModel {
  final String before;
  final String after;
  final Timestamp createdAt;

  AchivevementModel({
    required this.before,
    required this.after,
    required this.createdAt,
  });

  factory AchivevementModel.formJson(Map<String, dynamic> json) =>
      AchivevementModel(
        before: json['before'] ?? '',
        after: json['after'] ?? '',
        createdAt: json['createdAt'] ?? Timestamp.now(),
      );

  Map<String, dynamic> toJson() => {
        'before': before,
        'after': after,
        'createdAt': createdAt,
      };
}
