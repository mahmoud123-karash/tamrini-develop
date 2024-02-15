import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/features/favourite/data/models/meal_model/meal_model.dart';

abstract class FavoriteRemoteDataSource {
  Future<List<MealModel>> get();
}

class FavoriteRemoteDataSourceImpl extends FavoriteRemoteDataSource {
  @override
  Future<List<MealModel>> get() async {
    List<MealModel> list = [];
    String uid = CacheHelper.getData(key: 'uid');
    var result = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('favorite')
        .doc('data')
        .collection('meals')
        .get();

    for (var element in result.docs) {
      MealModel model = MealModel.fromJson(element.data());
      list.add(model);
    }
    var box = Hive.box<MealModel>(favoriteBox);
    box.addAll(list);
    return list;
  }
}
