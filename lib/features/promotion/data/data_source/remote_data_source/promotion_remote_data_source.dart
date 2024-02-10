import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tamrini/core/contants/constants.dart';
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
        .get();

    for (var element in result.docs) {
      list.add(PromotionModel.fromJson(element.data()));
    }
    return list;
  }
}
