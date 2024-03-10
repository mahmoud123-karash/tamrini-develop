import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/models/user_model/user_model.dart';
import 'package:tamrini/features/promotion/data/models/promotion_model/promotion_model.dart';

abstract class PromotionRemoteDataSource {
  Future<List<PromotionModel>> get();
}

class PromotionRemoteDataSourceImpl extends PromotionRemoteDataSource {
  @override
  Future<List<PromotionModel>> get() async {
    List<PromotionModel> list = [];
    var result = await FirebaseFirestore.instance
        .collection('users')
        .doc(adminUid)
        .collection('promotions')
        .orderBy(
          'requestTime',
          descending: true,
        )
        .get();

    for (var element in result.docs) {
      UserModel user = await getUser(element);
      list.add(PromotionModel.fromJson(element.data(), user));
    }
    return list;
  }

  Future<UserModel> getUser(
    QueryDocumentSnapshot<Map<String, dynamic>> element,
  ) async {
    String senderUid = element.data()['userId'] ?? '';

    var result = await FirebaseFirestore.instance
        .collection('users')
        .doc(senderUid)
        .get();
    UserModel user = UserModel.fromMap(result.data()!, result.id);
    return user;
  }
}
