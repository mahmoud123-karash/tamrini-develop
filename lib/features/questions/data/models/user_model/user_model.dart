class UserModel {
  final String name;
  final String image;
  final String token;
  final String uid;
  final String role;
  final bool isSubscribedToTrainer;
  final bool isSubscribedToGym;
  final bool isBanned;

  UserModel({
    required this.name,
    required this.image,
    required this.role,
    required this.token,
    required this.uid,
    required this.isSubscribedToTrainer,
    required this.isBanned,
    required this.isSubscribedToGym,
  });

  factory UserModel.fromMap(Map<String, dynamic> map, String uid) {
    return UserModel(
      name: map['name'] ?? '',
      image: map['image'] ?? '',
      isSubscribedToGym: map['isSubscribedToGym'] ?? false,
      token: map['token'] ?? '',
      uid: uid,
      isSubscribedToTrainer: map['isSubscribedToTrainer'] ?? false,
      role: map['role'] ?? 'user',
      isBanned: map['isBanned'] ?? false,
    );
  }
}
