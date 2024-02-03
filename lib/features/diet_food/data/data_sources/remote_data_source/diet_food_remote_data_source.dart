import 'package:cloud_firestore/cloud_firestore.dart';
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
      DietFoodModel model = DietFoodModel.fromJson(element.data(), element.id);
      list.add(model);
    }
    return list;
  }
}
