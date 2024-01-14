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
  final String uid;
  @HiveField(6)
  final String image;
  @HiveField(7)
  final bool isBanned;

  ProfileModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.uid,
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
      phone: map['phone'] ?? '',
      gender: map['gender'] ?? '',
      uid: map['uid'] ?? '',
      age: map['age'] ?? 0,
      isBanned: map['isBanned'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
      'image': image,
      'phone': phone,
      'gender': gender,
      'age': age,
      'uid': uid,
      'isBanned': isBanned,
    };
  }
}
