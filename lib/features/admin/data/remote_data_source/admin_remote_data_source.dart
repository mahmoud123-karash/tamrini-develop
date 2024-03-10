import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tamrini/core/models/user_model/user_model.dart';

abstract class AdminRemoteDataSource {
  Future<List<UserModel>> getUsers({required String userType});
}

class AdminRemoteDataSourceImpl extends AdminRemoteDataSource {
  @override
  Future<List<UserModel>> getUsers({required String userType}) async {
    var result = await FirebaseFirestore.instance
        .collection('users')
        .where('role', isEqualTo: userType)
        .get();
    List<UserModel> users = [];
    for (var element in result.docs) {
      UserModel model = UserModel.fromMap(
        element.data(),
        element.id,
      );
      users.add(model);
    }
    users = users.where((element) => element.isDeleted == false).toList();
    return users;
  }
}
