import 'package:tamrini/features/exercise/data/models/exercise_model/data_model.dart';

class ExerciseModel {
  String? image;
  List<DataModel>? data = [];
  String? title;
  int? order;
  String? id;

  ExerciseModel({
    this.image,
    this.data,
    this.title,
    this.id,
    this.order,
  });

  ExerciseModel.fromJson(Map<String, dynamic> json, this.id) {
    image = json['image'];
    if (json['data'] != null) {
      data = <DataModel>[];
      json['data'].forEach((v) {
        data!.add(DataModel.fromJson(v));
      });
    } else {
      data = <DataModel>[];
    }
    title = json['title'];
    order = json['order'] ?? 99;
  }

  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'data': data?.map((item) => item.toJson()).toList(),
      'title': title,
      'order': order,
    };
  }
}
