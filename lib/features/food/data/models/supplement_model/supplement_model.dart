import 'package:tamrini/features/food/data/models/supplement_model/supplement_data.dart';

class SupplementModel {
  final String image;
  final List<SupplementData> data;
  final String title;
  String? id;

  SupplementModel({
    required this.image,
    required this.data,
    required this.title,
    this.id,
  });

  factory SupplementModel.fromJson(Map<String, dynamic> json, String id) {
    final List<dynamic> sJson = json['data'] ?? [];
    List<SupplementData> list = sJson.map((e) {
      return SupplementData.fromJson(e, json['title'] ?? '');
    }).toList();
    return SupplementModel(
      image: json['image'] ?? '',
      data: list,
      title: json['title'] ?? '',
      id: id,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image'] = image;
    data['data'] = this.data.map((v) => v.toJson()).toList();
    data['title'] = title;
    return data;
  }
}
