class UserModel {
  final String name;
  final String image;
  final String token;
  final String uid;
  final String role;
  final String phone;
  final String whatsApp;
  final String facebookUri;
  final String instgramUri;
  final String twiterUri;
  final String address;
  final String email;
  final bool isBanned;
  final bool isDeleted;
  final String gender;

  UserModel({
    required this.name,
    required this.image,
    required this.role,
    required this.token,
    required this.uid,
    required this.isDeleted,
    required this.facebookUri,
    required this.whatsApp,
    required this.isBanned,
    required this.phone,
    required this.instgramUri,
    required this.twiterUri,
    required this.address,
    required this.email,
    required this.gender,
  });

  factory UserModel.fromMap(
      Map<String, dynamic> map, String uid, String address) {
    return UserModel(
      name: map['name'] ?? '',
      image: map['image'] ?? '',
      facebookUri: map['facebookUri'] ?? '',
      token: map['token'] ?? '',
      phone: map['phone'] ?? '',
      whatsApp: map['whatsApp'] ?? '',
      uid: uid,
      instgramUri: map['instgramUri'] ?? '',
      twiterUri: map['twiterUri'] ?? '',
      email: map['email'] ?? '',
      role: map['role'] ?? 'user',
      gender: map['gender'] ?? '',
      address: address,
      isBanned: map['isBanned'] ?? false,
      isDeleted: map['isDeleted'] ?? false,
    );
  }
}
