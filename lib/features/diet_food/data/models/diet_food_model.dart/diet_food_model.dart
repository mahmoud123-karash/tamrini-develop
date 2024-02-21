import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/models/user_model/user_model.dart';

class DietFoodModel {
  final List<String> assets;
  final String description;
  final String title;
  final String id;
  final Timestamp date;
  final String writerUid;
  final bool isRefused;
  final bool isPending;
  UserModel? user;

  DietFoodModel({
    required this.assets,
    required this.description,
    required this.title,
    required this.date,
    required this.id,
    required this.writerUid,
    required this.isRefused,
    required this.isPending,
    this.user,
  });

  factory DietFoodModel.fromJson(
      Map<String, dynamic> json, String id, UserModel user) {
    return DietFoodModel(
      assets: json['assets'].cast<String>(),
      description: json['description'],
      title: json['title'],
      date: json['date'] ?? Timestamp.now(),
      writerUid: json['writerUid'] ?? adminUid,
      isRefused: json['isRefused'] ?? false,
      isPending: json['isPending'] ?? false,
      id: id,
      user: user,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['assets'] = assets;
    data['description'] = description;
    data['title'] = title;
    data['date'] = date;
    data['isRefused'] = isRefused;
    data['isPending'] = isPending;
    data['writerUid'] = writerUid;

    return data;
  }
}
