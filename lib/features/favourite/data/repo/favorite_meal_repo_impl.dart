import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/features/favourite/data/data_sources/local_data_source/favorite_local_data_source.dart';
import 'package:tamrini/features/favourite/data/data_sources/remote_data_source/favorite_remote_data_source.dart';
import 'package:tamrini/features/favourite/data/models/meal_model/meal_model.dart';
import 'package:tamrini/features/favourite/domain/repo/favorite_repo.dart';

class FavoriteRepoImpl extends FavoriteRepo {
  final FavoriteRemoteDataSource favoriteRemoteDataSource;
  final FavoriteLocalDataSource favoriteLocalDataSource;

  FavoriteRepoImpl(this.favoriteRemoteDataSource, this.favoriteLocalDataSource);

  @override
  Future<Either<String, List<MealModel>>> getFavoriteMeals() async {
    try {
      List<MealModel> localList = favoriteLocalDataSource.get();
      if (localList.isNotEmpty) {
        return right(localList);
      } else {
        List<MealModel> list = await favoriteRemoteDataSource.get();
        return right(list);
      }
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, List<MealModel>>> addFavoriteMeal({
    required MealModel meal,
  }) async {
    try {
      String uid = CacheHelper.getData(key: 'uid');

      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('favorite')
          .doc('data')
          .collection('meals')
          .doc(meal.id)
          .set(
            meal.toJson(),
          );
      var box = Hive.box<MealModel>(favoriteBox);
      await box.add(meal);
      List<MealModel> list = [];
      list = box.values.toList();
      return right(list);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, List<MealModel>>> removeFavoriteMeal({
    required MealModel meal,
  }) async {
    try {
      String uid = CacheHelper.getData(key: 'uid');
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('favorite')
          .doc('data')
          .collection('meals')
          .doc(meal.id)
          .delete();
      var box = Hive.box<MealModel>(favoriteBox);
      List<MealModel> list = box.values.toList();
      list.remove(meal);
      await box.clear();
      await box.addAll(list);
      return right(list);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, List<MealModel>>> editFavoriteMeal({
    required MealModel meal,
    required num wieght,
  }) async {
    try {
      MealModel model = MealModel(
        carbs: meal.carbs,
        protein: meal.protein,
        fat: meal.fat,
        calories: meal.calories,
        id: meal.id,
        name: meal.name,
        wieght: wieght,
      );
      String uid = CacheHelper.getData(key: 'uid');
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('favorite')
          .doc('data')
          .collection('meals')
          .doc(meal.id)
          .update(model.toJson());
      var box = Hive.box<MealModel>(favoriteBox);
      List<MealModel> list = box.values.toList();
      list.remove(meal);
      list.add(model);
      await box.clear();
      await box.addAll(list);
      return right(list);
    } catch (e) {
      return left(e.toString());
    }
  }
}
