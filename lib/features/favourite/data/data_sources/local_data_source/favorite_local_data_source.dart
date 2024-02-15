import 'package:hive/hive.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/features/favourite/data/models/meal_model/meal_model.dart';

abstract class FavoriteLocalDataSource {
  List<MealModel> get();
}

class FavoriteLocalDataSourceImpl extends FavoriteLocalDataSource {
  @override
  List<MealModel> get() {
    var box = Hive.box<MealModel>(favoriteBox);
    List<MealModel> list = box.values.toList();
    return list;
  }
}
