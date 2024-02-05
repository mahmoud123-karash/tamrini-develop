import 'exercise_data.dart';

class HomeExerciseModel {
  String? image;
  List<Data>? data;
  String? title;
  String? id;
  int? order;

  HomeExerciseModel({
    this.image,
    this.data,
    this.title,
    this.id,
    this.order,
  });

  HomeExerciseModel.fromJson(Map<String, dynamic> json, this.id) {
    image = json['image'] ?? '';
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    title = json['title'] ?? '';
    order = json['order'] ?? 99;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image'] = image;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['title'] = title;
    data['order'] = order ?? 99;
    return data;
  }
}
