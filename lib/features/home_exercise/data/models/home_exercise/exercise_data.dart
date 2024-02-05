import 'package:tamrini/core/contants/constants.dart';

class Data {
  List<String>? assets;
  String? description;
  String? title;
  String? id;
  String? writerUid;

  Data({
    this.assets,
    this.description,
    this.title,
    required this.id,
    this.writerUid,
  });

  Data.fromJson(Map<String, dynamic> json) {
    assets = json['image'].cast<String>();
    description = json['description'] ?? '';
    title = json['title'] ?? '';
    id = json['id'] ?? '';
    writerUid = json['writerUid'] ?? adminUid;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image'] = assets;
    data['description'] = description;
    data['title'] = title;
    data['id'] = id;
    data['writerUid'] = writerUid;
    return data;
  }
}
