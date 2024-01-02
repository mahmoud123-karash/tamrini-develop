import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/user_model/user_model.dart';

abstract class UserRemoteDataSource {
  Future<UserModel> get({required String uid});
}

class UserRemoteDataSourceImpl extends UserRemoteDataSource {
  @override
  Future<UserModel> get({
    required String uid,
  }) async {
    var result =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    UserModel user = UserModel.fromMap(result.data()!);
    return user;
  }
}
