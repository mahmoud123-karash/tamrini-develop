import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tamrini/core/models/user_model/user_model.dart';
import 'package:tamrini/core/services/location.dart';

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
      GeoPoint location =
          element.data()['location'] ?? const GeoPoint(33.312805, 44.361488);
      String address = await getAddress(location: location);
      UserModel model = UserModel.fromMap(
        element.data(),
        element.id,
        address,
      );
      users.add(model);
    }
    return users;
  }
}
