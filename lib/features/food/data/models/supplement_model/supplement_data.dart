import 'package:tamrini/core/contants/constants.dart';

class SupplementData {
  final List<String> images;
  final String description;
  final String title;
  final String id;
  final String writerUid;

  SupplementData({
    required this.images,
    required this.description,
    required this.title,
    required this.id,
    required this.writerUid,
  });

  factory SupplementData.fromJson(Map<String, dynamic> json) {
    return SupplementData(
      images: List<String>.from(json['images']),
      description: json['description'] ?? '',
      title: json['title'] ?? '',
      id: json['id'] ?? '',
      writerUid: json['writerUid'] ?? adminUid,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['images'] = images;
    data['description'] = description;
    data['title'] = title;
    data['id'] = id;
    data['writerUid'] = writerUid;
    return data;
  }
}
