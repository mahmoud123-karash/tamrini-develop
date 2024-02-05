import 'package:tamrini/core/contants/constants.dart';

class Data {
  final List<String> assets;
  final String description;
  final String title;
  final String id;
  final String writerUid;
  String? sectionId;

  Data({
    required this.assets,
    required this.description,
    required this.title,
    required this.id,
    required this.writerUid,
    this.sectionId,
  });

  factory Data.fromJson(Map<String, dynamic> json, sectionId) {
    return Data(
      assets: List<String>.from(json['image'] ?? []),
      description: json['description'] ?? '',
      title: json['title'] ?? '',
      id: json['id'] ?? '',
      writerUid: json['writerUid'] ?? adminUid,
      sectionId: sectionId,
    );
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
