import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/models/user_model/user_model.dart';
import 'package:tamrini/core/services/services.dart';
import 'package:tamrini/features/profits/data/models/profits_model/profits_model.dart';

abstract class ProfitsRemoteDataSource {
  Future<List<ProfitsModel>> get();
  Future<List<ProfitsModel>> getMyRequest({required String uid});
}

class ProfitsRemoteDataSourceImpl extends ProfitsRemoteDataSource {
  @override
  Future<List<ProfitsModel>> get() async {
    List<ProfitsModel> list = [];
    var result = await FirebaseFirestore.instance
        .collection('profits')
        .orderBy('requestedAt', descending: true)
        .get();
    for (var element in result.docs) {
      UserModel user = await getUser(element.data()['userId'] ?? adminUid);
      ProfitsModel model = ProfitsModel.fromJson(element.data(), user);
      list.add(model);
    }
    return list;
  }

  @override
  Future<List<ProfitsModel>> getMyRequest({required String uid}) async {
    List<ProfitsModel> list = [];
    var result = await FirebaseFirestore.instance
        .collection('profits')
        .where('uid', isEqualTo: uid)
        .get();
    for (var element in result.docs) {
      UserModel user = await getUser(element.data()['userId'] ?? adminUid);
      ProfitsModel model = ProfitsModel.fromJson(element.data(), user);
      list.add(model);
    }
    return list;
  }
}
