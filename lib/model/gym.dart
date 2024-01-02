import 'package:cloud_firestore/cloud_firestore.dart';

class Gym {
  late List<String> assets;
  late String name;
  late GeoPoint location;
  late int price;
  late String id;
  late String description;
  late double distance;

  Gym({
    required this.assets,
    required this.name,
    required this.location,
    required this.price,
    required this.id,
    required this.description,
    required this.distance,
  });

  Gym.fromJson(Map<String, dynamic> json, String id, double distinction) {
    assets = json['assets'].cast<String>();
    name = json['name'];
    location = json['location'];
    price = json['price'];
    this.id = id;
    description = json['description'];
    distance = distinction;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['assets'] = this.assets;
    data['name'] = this.name;
    data['location'] = this.location;
    data['price'] = this.price;
    data['description'] = this.description;
    return data;
  }
}
