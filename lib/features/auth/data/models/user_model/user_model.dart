class UserModel {
  final String name;
  final String email;
  final String phone;
  final int age;
  final String gender;
  final String token;
  final String uid;
  final bool isSubscribedToTrainer;
  final bool isSubscribedToPublisher;
  final bool isSubscribedToStoreOwner;
  final bool isBanned;

  UserModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.token,
    required this.uid,
    required this.gender,
    required this.age,
    required this.isSubscribedToTrainer,
    required this.isBanned,
    required this.isSubscribedToPublisher,
    required this.isSubscribedToStoreOwner,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
      'phone': phone,
      'token': token,
      'gender': gender,
      'age': age,
      'uid': uid,
      'isSubscribedToTrainer': isSubscribedToTrainer,
      'isBanned': isBanned,
      'isSubscribedToStroreOwner': isSubscribedToStoreOwner,
      'isSubscribedToPublisher': isSubscribedToPublisher,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      isSubscribedToPublisher: map['isSubscribedToPublisher'] ?? false,
      isSubscribedToStoreOwner: map['isSubscribedToStoreOwner'] ?? false,
      token: map['token'] ?? '',
      gender: map['gender'] ?? '',
      uid: map['uid'] ?? '',
      age: map['age'] ?? 0,
      isSubscribedToTrainer: map['isSubscribedToTrainer'] ?? false,
      isBanned: map['isBanned'] ?? false,
    );
  }
}
