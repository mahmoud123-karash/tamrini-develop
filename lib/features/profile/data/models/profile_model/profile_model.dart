import 'package:hive_flutter/hive_flutter.dart';
part 'profile_model.g.dart';

@HiveType(typeId: 1)
class ProfileModel {
  @HiveField(10)
  final String name;
  @HiveField(11)
  final String email;
  @HiveField(12)
  final String phone;
  @HiveField(13)
  final int age;
  @HiveField(14)
  final String gender;
  @HiveField(15)
  final String image;
  @HiveField(16)
  final bool isBanned;
  @HiveField(17)
  final String facebookUri;
  @HiveField(18)
  final String instgramUri;
  @HiveField(19)
  final String twiterUri;
  @HiveField(20)
  final String address;

  ProfileModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.facebookUri,
    required this.instgramUri,
    required this.twiterUri,
    required this.address,
    required this.gender,
    required this.image,
    required this.age,
    required this.isBanned,
  });

  factory ProfileModel.fromMap(Map<String, dynamic> map, String address) {
    return ProfileModel(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      image: map['image'] ?? '',
      facebookUri: map['facebookUri'] ?? '',
      phone: map['phone'] ?? '',
      gender: map['gender'] ?? '',
      instgramUri: map['instgramUri'] ?? '',
      twiterUri: map['twiterUri'] ?? '',
      address: address,
      age: map['age'] ?? 0,
      isBanned: map['isBanned'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
      'instgramUri': instgramUri,
      'image': image,
      'phone': phone,
      'gender': gender,
      'age': age,
      'facebookUri': facebookUri,
      'twiterUri': twiterUri,
      'isBanned': isBanned,
    };
  }
}
