import 'package:cloud_firestore/cloud_firestore.dart';

class FollowUpModel {
  final Timestamp createdAt;
  final List<FollowUpData> followUpData;
  final List<String> images;

  FollowUpModel({
    required this.createdAt,
    required this.followUpData,
    required this.images,
  });

  factory FollowUpModel.fromJson(Map<String, dynamic> json) {
    final List<FollowUpData> dataList = [];
    if (json['followUpData'] != null) {
      for (var element in json['followUpData']) {
        dataList.add(FollowUpData.fromJson(element));
      }
    }
    return FollowUpModel(
      createdAt: json['createdAt'] ?? Timestamp.now(),
      followUpData: dataList,
      images: List<String>.from(json['createdAt'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['createdAt'] = createdAt;
    data['followUpData'] = followUpData.map((data) => data.toJson()).toList();
    data['images'] = images;
    return data;
  }
}

class FollowUpData {
  final String question;
  final String answer;

  FollowUpData({
    required this.question,
    required this.answer,
  });

  factory FollowUpData.fromJson(Map<String, dynamic> json) {
    return FollowUpData(
      question: json['question'] ?? '',
      answer: json['answer'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['question'] = question;
    data['answer'] = answer;
    return data;
  }
}
