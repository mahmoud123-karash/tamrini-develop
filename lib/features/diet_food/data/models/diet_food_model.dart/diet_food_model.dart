import 'package:cloud_firestore/cloud_firestore.dart';

class DietFoodModel {
  final List<String> assets;
  final String description;
  final String title;
  final String id;
  final Timestamp date;
  final String writer;
  final String writerUid;

  DietFoodModel({
    required this.assets,
    required this.description,
    required this.title,
    required this.date,
    required this.writer,
    required this.id,
    required this.writerUid,
  });

  factory DietFoodModel.fromJson(Map<String, dynamic> json, String id) {
    return DietFoodModel(
      assets: json['assets'].cast<String>(),
      description: json['description'],
      title: json['title'],
      date: json['date'] ?? Timestamp.now(),
      writerUid: json['writerUid'] ?? '',
      id: id,
      writer: json['writer'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['assets'] = assets;
    data['description'] = description;
    data['title'] = title;
    data['date'] = date;
    data['writerUid'] = writerUid;
    data['writer'] = writer;

    return data;
  }
}
