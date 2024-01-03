import 'package:hive/hive.dart';

part 'data_model.g.dart';

@HiveType(typeId: 1)
class DataModel {
  @HiveField(0)
  List<String>? assets;
  @HiveField(1)
  String? description;
  @HiveField(2)
  String? title;
  @HiveField(3)
  String? id;

  DataModel({
    this.assets,
    this.description,
    this.title,
    required this.id,
  });

  DataModel.fromJson(Map<String, dynamic> json) {
    assets = json['image'].cast<String>();
    description = json['description'];
    title = json['title'];
    id = json['id'];
  }
}
