import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tamrini/features/auth/data/models/user_model/user_model.dart';
import 'package:tamrini/features/auth/domain/repo/register_repo.dart';

class RegisterRepoImpl extends RegisterRepo {
  @override
  Future<String> signUp({
    required String email,
    required String password,
  }) async {
    var user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    return user.user!.uid;
  }

  @override
  void createUser({
    required String name,
    required String email,
    required String phone,
    required String gender,
    required String uid,
  }) async {
    UserModel model = UserModel(
      name: name,
      email: email,
      phone: phone,
      uid: uid,
      gender: gender,
      role: 'user',
      trainerId: '',
    );
    await FirebaseFirestore.instance.collection('users').doc(uid).set(
          model.toMap(),
        );
  }
}
