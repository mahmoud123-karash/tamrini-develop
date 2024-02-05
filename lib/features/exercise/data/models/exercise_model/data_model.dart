import 'package:tamrini/core/contants/constants.dart';

class DataModel {
  List<String>? assets;
  String? description;
  String? title;
  String? id;
  String? writerUid;

  DataModel({
    this.assets,
    this.description,
    this.title,
    required this.writerUid,
    required this.id,
  });

  DataModel.fromJson(Map<String, dynamic> json) {
    assets = List<String>.from(json['image'] ?? []);
    description = json['description'] ?? '';
    title = json['title'] ?? "";
    id = json['id'] ?? '';
    writerUid = json['writerUid'] ?? adminUid;
  }

  Map<String, dynamic> toJson() {
    return {
      'image': assets,
      'description': description,
      'title': title,
      'id': id,
      'writerUid': writerUid,
    };
  }
}
