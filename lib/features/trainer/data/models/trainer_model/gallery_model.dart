import 'package:cloud_firestore/cloud_firestore.dart';

class GalleryModel {
  final String before;
  final String after;
  final Timestamp createdAt;

  GalleryModel({
    required this.before,
    required this.after,
    required this.createdAt,
  });

  factory GalleryModel.formJson(Map<String, dynamic> json) =>
      GalleryModel(
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
