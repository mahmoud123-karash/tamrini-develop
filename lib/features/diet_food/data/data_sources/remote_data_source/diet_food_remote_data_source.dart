import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/models/user_model/user_model.dart';
import 'package:tamrini/core/services/services.dart';
import 'package:tamrini/features/diet_food/data/models/diet_food_model.dart/diet_food_model.dart';

abstract class DietFoodRemoteDataSource {
  Future<List<DietFoodModel>> get();
}

class DietFoodRemoteDataSourceImpl extends DietFoodRemoteDataSource {
  @override
  Future<List<DietFoodModel>> get() async {
    List<DietFoodModel> list = [];
    var result = await FirebaseFirestore.instance
        .collection('dietFood')
        .doc('data')
        .collection('data')
        .orderBy('date', descending: true)
        .get();

    for (var element in result.docs) {
      UserModel? user = await getUser(element.data()['writerUid'] ?? adminUid);
      DietFoodModel model =
          DietFoodModel.fromJson(element.data(), element.id, user);
      list.add(model);
    }
    return list;
  }
}
