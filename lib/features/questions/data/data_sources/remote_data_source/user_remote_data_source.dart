import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tamrini/core/services/location.dart';
import 'package:tamrini/features/questions/data/models/user_model/user_model.dart';

abstract class UserRemoteDataSource {
  Future<UserModel> get({required String uid});
}

class UserRemoteDataSourceImpl extends UserRemoteDataSource {
  @override
  Future<UserModel> get({required String uid}) async {
    var result =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    GeoPoint location =
        result.data()!['location'] ?? const GeoPoint(33.312805, 44.361488);
    String address = await getAddress(location: location);
    UserModel model = UserModel.fromMap(result.data()!, result.id, address);
    return model;
  }
}
