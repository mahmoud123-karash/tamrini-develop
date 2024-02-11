import 'package:cloud_firestore/cloud_firestore.dart';

class FoodModel {
  final String duration;
  final String title;
  final Timestamp createdAt;
  final String satData;
  final String sunData;
  final String monData;
  final String tueData;
  final String wedData;
  final String thursData;
  final String friData;

  FoodModel(
      {required this.duration,
      required this.title,
      required this.createdAt,
      required this.satData,
      required this.sunData,
      required this.monData,
      required this.tueData,
      required this.wedData,
      required this.thursData,
      required this.friData});

  factory FoodModel.fromJson(Map<String, dynamic> json) {
    return FoodModel(
      duration: json['duration'] ?? '',
      title: json['title:'] ?? '',
      createdAt: json['createdAt'] ?? Timestamp.now(),
      satData: json['satData'] ?? '',
      sunData: json['sunData'] ?? '',
      monData: json['monData'] ?? '',
      tueData: json['tueData'] ?? '',
      wedData: json['wedData'] ?? '',
      thursData: json['thursData'] ?? '',
      friData: json['friData'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['createdAt'] = createdAt;
    data['duration'] = duration;
    data['satData'] = satData;
    data['sunData'] = sunData;
    data['monData'] = monData;
    data['tueData'] = tueData;
    data['wedData'] = wedData;
    data['thursData'] = thursData;
    data['friData'] = friData;
    return data;
  }
}
