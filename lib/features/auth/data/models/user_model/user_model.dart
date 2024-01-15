class UserModel {
  final String name;
  final String email;
  final String phone;
  final int age;
  final String gender;
  final String token;
  final String uid;
  final String role;
  final bool isSubscribedToTrainer;
  final bool isSubscribedToGym;
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
    required this.isSubscribedToGym,
    required this.isBanned,
    required this.role,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
      'phone': phone,
      'token': token,
      'isSubscribedToGym': isSubscribedToGym,
      'gender': gender,
      'age': age,
      'uid': uid,
      'isSubscribedToTrainer': isSubscribedToTrainer,
      'role': role,
      'isBanned': isBanned,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      role: map['role'] ?? 'user',
      isSubscribedToGym: map['isSubscribedToGym'] ?? false,
      token: map['token'] ?? '',
      gender: map['gender'] ?? '',
      uid: map['uid'] ?? '',
      age: map['age'] ?? 0,
      isSubscribedToTrainer: map['isSubscribedToTrainer'] ?? false,
      isBanned: map['isBanned'] ?? false,
    );
  }
}
