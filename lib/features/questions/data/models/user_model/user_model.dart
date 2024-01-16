class UserModel {
  final String name;
  final String image;
  final String token;
  final String uid;
  final String role;
  final String phone;
  final String facebookUri;
  final String instgramUri;
  final String twiterUri;
  final String address;
  final bool isBanned;

  UserModel({
    required this.name,
    required this.image,
    required this.role,
    required this.token,
    required this.uid,
    required this.facebookUri,
    required this.isBanned,
    required this.phone,
    required this.instgramUri,
    required this.twiterUri,
    required this.address,
  });

  factory UserModel.fromMap(
      Map<String, dynamic> map, String uid, String address) {
    return UserModel(
      name: map['name'] ?? '',
      image: map['image'] ?? '',
      facebookUri: map['facebookUri'] ?? '',
      token: map['token'] ?? '',
      phone: map['phone'] ?? '',
      uid: uid,
      instgramUri: map['instgramUri'] ?? '',
      twiterUri: map['twiterUri'] ?? '',
      role: map['role'] ?? 'user',
      address: address,
      isBanned: map['isBanned'] ?? false,
    );
  }
}
