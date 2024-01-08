import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tamrini/features/trainer/data/models/trainer_model/achievement_model.dart';

class TrainerModel {
  final String name;
  final bool isBanned;
  final String image;
  final String description;
  final String gender;
  final int price;
  final List<String> contacts;
  final int traineesCount;
  final String uid;
  final List<String> questions;
  final List<AchivevementModel> gallery;
  final GeoPoint location;
  final String address;
  final String fromH;
  final String toH;
  final double rating;

  TrainerModel({
    required this.location,
    required this.rating,
    required this.address,
    required this.fromH,
    required this.toH,
    required this.isBanned,
    required this.name,
    required this.image,
    required this.description,
    required this.contacts,
    required this.uid,
    required this.price,
    required this.traineesCount,
    required this.gender,
    required this.questions,
    required this.gallery,
  });

  factory TrainerModel.fromJson(
      Map<String, dynamic> json, String address, double rating) {
    List<AchivevementModel> list = [];
    if (json['gallery'] != null) {
      json['gallery'].forEach(
        (element) {
          AchivevementModel model = AchivevementModel.formJson(element);
          list.add(model);
        },
      );
    }
    return TrainerModel(
      isBanned: json['isBanned'] ?? false,
      name: json['name'],
      fromH: json['fromH'] ?? '',
      toH: json['toH'] ?? '',
      address: address,
      rating: rating,
      location: json['location'] ?? const GeoPoint(33.312805, 44.361488),
      image: json['image'] ?? '',
      description: json['achievements'] ?? "",
      contacts: json['contacts'].cast<String>(),
      price: json['price'],
      gender: json['gender'],
      traineesCount: json['traineesCount'],
      uid: json['uid'],
      questions: json['questions'].cast<String>(),
      gallery: list,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isBanned'] = isBanned;
    data['name'] = name;
    data['image'] = image;
    data['achievements'] = description;
    data['contacts'] = contacts;
    data['uid'] = uid;
    data['location'] = location;
    data['price'] = price;
    data['gender'] = gender;
    data['fromH'] = fromH;
    data['toH'] = toH;
    data['traineesCount'] = traineesCount;
    data['questions'] = questions;
    data['gallery'] = gallery;
    return data;
  }
}
