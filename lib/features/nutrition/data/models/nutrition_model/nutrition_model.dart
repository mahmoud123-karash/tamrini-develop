import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/models/user_model/user_model.dart';

class NutritionModel {
  final String title;
  final double calories;
  final double proteins;
  final double fats;
  final double carbs;
  String? id;
  String? categryId;
  final String writerUid;
  UserModel? user;

  NutritionModel({
    required this.title,
    required this.calories,
    required this.proteins,
    required this.fats,
    required this.carbs,
    required this.writerUid,
    this.id,
    this.categryId,
    this.user,
  });

  factory NutritionModel.fromJson(
      Map<String, dynamic> json, id, categryId, user) {
    return NutritionModel(
      title: json['title'] ?? '',
      calories: json['calories'] ?? 0.0,
      proteins: json['proteins'] ?? 0.0,
      fats: json['fats'] ?? 0.0,
      writerUid: json['writerUid'] ?? adminUid,
      carbs: json['carbs'] ?? 0.0,
      id: id,
      categryId: categryId,
      user: user,
    );
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'calories': calories,
        'proteins': proteins,
        'fats': fats,
        'carbs': carbs,
        "writerUid": writerUid,
      };
}
