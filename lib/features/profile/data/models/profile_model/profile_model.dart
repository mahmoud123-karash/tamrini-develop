import 'package:hive_flutter/hive_flutter.dart';

part 'profile_model.g.dart';

@HiveType(typeId: 1)
class ProfileModel {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String email;
  @HiveField(2)
  final String phone;
  @HiveField(3)
  final int age;
  @HiveField(4)
  final String gender;
  @HiveField(5)
  final bool isSubscribedToTrainer;
  @HiveField(6)
  final String image;
  @HiveField(7)
  final bool isBanned;
  @HiveField(8)
  final bool isSubscribedToGym;

  ProfileModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.isSubscribedToTrainer,
    required this.isSubscribedToGym,
    required this.gender,
    required this.image,
    required this.age,
    required this.isBanned,
  });

  factory ProfileModel.fromMap(Map<String, dynamic> map) {
    return ProfileModel(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      image: map['image'] ?? '',
      isSubscribedToGym: map['isSubscribedToGym'] ?? false,
      phone: map['phone'] ?? '',
      gender: map['gender'] ?? '',
      isSubscribedToTrainer: map['isSubscribedToTrainer'] ?? false,
      age: map['age'] ?? 0,
      isBanned: map['isBanned'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
      'isSubscribedToGym': isSubscribedToGym,
      'image': image,
      'phone': phone,
      'gender': gender,
      'age': age,
      'isSubscribedToTrainer': isSubscribedToTrainer,
      'isBanned': isBanned,
    };
  }
}
