class User {
  String name;
  String email;
  String phone;
  String username;
  String password;
  String token;
  String role;
  String uid;
  String gender;
  int age;
  bool isSubscribedToTrainer = false;
  bool isBanned = false;
  bool isVerifiedPhoneNumber = false;
  bool notification = false;
  List notifications = [];
  bool isVerifiedEmail = false;
  String pendingEmail = "";

  User(
      {required this.name,
      required this.email,
      required this.phone,
      required this.username,
      required this.password,
      required this.token,
      required this.role,
      required this.uid,
      required this.gender,
      required this.age,
      required this.isSubscribedToTrainer,
      required this.isBanned,
      required this.isVerifiedPhoneNumber,
      required this.notification,
      required this.notifications,
      required this.isVerifiedEmail,
      required this.pendingEmail});

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
      'username': username,
      'phone': phone,
      'token': token,
      'password': password,
      'role': 'user',
      'gender': gender,
      'age': age,
      'isSubscribedToTrainer': isSubscribedToTrainer,
      'isBanned': isBanned,
      'isVerifiedPhoneNumber': isVerifiedPhoneNumber,
      'notification': notification,
      'notifications': notifications,
    };
  }

  factory User.fromMap(Map<String, dynamic> map, id) {
    return User(
        name: map['name'],
        email: map['email'],
        phone: map['phone'],
        username: map['username'],
        password: map['password'],
        token: map['token'],
        role: map['role'],
        gender: map['gender'],
        uid: id,
        age: map['age'],
        isSubscribedToTrainer: map['isSubscribedToTrainer'],
        isBanned: map['isBanned'],
        isVerifiedPhoneNumber: map['isVerifiedPhoneNumber'],
        notification:
            map.containsKey('notification') ? map['notification'] : false,
        notifications:
            map.containsKey('notifications') ? map['notifications'] : [],
        isVerifiedEmail: map['isVerifiedEmail'] ?? false,
        pendingEmail: map['pendingEmail'] ?? "");
  }

  User copyWith({bool? isEmail, String? email, String? pendingEmail}) {
    return User(
        name: name,
        email: email ?? this.email,
        phone: phone,
        username: username,
        password: password,
        token: token,
        role: role,
        uid: uid,
        gender: gender,
        age: age,
        isSubscribedToTrainer: isSubscribedToTrainer,
        isBanned: isBanned,
        isVerifiedPhoneNumber: isVerifiedPhoneNumber,
        notification: notification,
        notifications: notifications,
        isVerifiedEmail: isEmail ?? isVerifiedEmail,
        pendingEmail: pendingEmail ?? this.pendingEmail);
  }
}
