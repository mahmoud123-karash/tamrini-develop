import 'package:cloud_firestore/cloud_firestore.dart';

class BannerModel {
  final String id;
  final String image;
  final String uri;
  final Timestamp addedAt;

  BannerModel({
    required this.id,
    required this.image,
    required this.uri,
    required this.addedAt,
  });

  factory BannerModel.fromjson(Map<String, dynamic> json) => BannerModel(
        id: json['id'] ?? '',
        image: json['image'] ?? '',
        uri: json['uri'] ?? '',
        addedAt: json['addedAt'] ?? Timestamp.now(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "uri": uri,
        "addedAt": addedAt,
      };
}
