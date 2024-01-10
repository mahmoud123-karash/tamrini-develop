class UserModel {
  final String name;
  final String image;
  final String token;
  final String uid;
  final bool isSubscribedToTrainer;
  final bool isSubscribedToGymOwner;
  final bool isSubscribedToPiblisher;
  final bool isSubscribedToStoreOwner;
  final bool admin;
  final bool isBanned;

  UserModel({
    required this.name,
    required this.image,
    required this.admin,
    required this.token,
    required this.uid,
    required this.isSubscribedToTrainer,
    required this.isSubscribedToPiblisher,
    required this.isBanned,
    required this.isSubscribedToGymOwner,
    required this.isSubscribedToStoreOwner,
  });

  factory UserModel.fromMap(Map<String, dynamic> map, String uid) {
    return UserModel(
      name: map['name'] ?? '',
      image: map['image'] ?? '',
      isSubscribedToGymOwner: map['isSubscribedToGymOwner'] ?? false,
      isSubscribedToPiblisher: map['isSubscribedToPiblisher'] ?? false,
      isSubscribedToStoreOwner: map['isSubscribedToStoreOwner'] ?? false,
      token: map['token'] ?? '',
      uid: uid,
      isSubscribedToTrainer: map['isSubscribedToTrainer'] ?? false,
      admin: map['admin'] ?? false,
      isBanned: map['isBanned'] ?? false,
    );
  }
}
