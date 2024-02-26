class UserModel {
  final String name;
  final String email;
  final String phone;
  final String gender;
  final String uid;
  final String role;
  final String trainerId;

  UserModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.uid,
    required this.gender,
    required this.role,
    required this.trainerId,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
      'phone': phone,
      'gender': gender,
      'uid': uid,
      'role': role,
      'trainerId': trainerId,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      role: map['role'] ?? 'user',
      gender: map['gender'] ?? '',
      uid: map['uid'] ?? '',
      trainerId: map['trainerId'] ?? '',
    );
  }
}
