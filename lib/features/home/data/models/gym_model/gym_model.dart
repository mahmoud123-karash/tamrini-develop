import 'package:cloud_firestore/cloud_firestore.dart';

class GymModel {
  final List<String> assets;
  final String name;
  final GeoPoint location;
  final int price;
  final String id;
  final String description;
  final double distance;
  final String ownerUid;

  GymModel({
    required this.assets,
    required this.name,
    required this.location,
    required this.price,
    required this.id,
    required this.description,
    required this.distance,
    required this.ownerUid,
  });

  factory GymModel.fromJson(
          Map<String, dynamic> json, String id, double distance) =>
      GymModel(
        assets: List<String>.from(json['assets'] ?? []),
        name: json['name'] ?? '',
        location: json['location'] ?? const GeoPoint(0, 0),
        price: json['price'] ?? '',
        id: id,
        description: json['description'] ?? '',
        ownerUid: json['ownerUid'] ?? '',
        distance: distance,
      );

  Map<String, dynamic> toJson() => {
        'assets': assets,
        'name': name,
        'location': location,
        'price': price,
        'ownerUid': ownerUid,
        'description': description,
      };
}
