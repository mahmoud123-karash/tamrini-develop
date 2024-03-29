import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tamrini/core/contants/constants.dart';

class GymModel {
  final List<String> assets;
  final String name;
  final GeoPoint location;
  final int price;
  final String id;
  final String description;
  final double distance;
  final String ownerUid;
  final bool isBanned;
  final int subcribersCount;
  final num profits;

  GymModel({
    required this.assets,
    required this.name,
    required this.location,
    required this.price,
    required this.id,
    required this.description,
    required this.distance,
    required this.ownerUid,
    required this.isBanned,
    required this.subcribersCount,
    required this.profits,
  });

  factory GymModel.fromJson(
    Map<String, dynamic> json,
    String id,
    double distance,
  ) =>
      GymModel(
        assets: List<String>.from(json['assets'] ?? []),
        name: json['name'] ?? '',
        location: json['location'] ?? const GeoPoint(0, 0),
        price: json['price'] ?? 0,
        id: id,
        description: json['description'] ?? '',
        ownerUid: json['gymOwnerId'] ?? adminUid,
        isBanned: json['isBanned'] ?? false,
        subcribersCount: json['subcribersCount'] ?? 0,
        profits: json['profits'] ?? 0,
        distance: distance,
      );

  Map<String, dynamic> toJson() => {
        'assets': assets,
        'name': name,
        'location': location,
        'price': price,
        'gymOwnerId': ownerUid,
        'isBanned': isBanned,
        'profits': profits,
        'subcribersCount': subcribersCount,
        'description': description,
      };
}
