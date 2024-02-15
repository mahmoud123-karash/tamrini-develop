import 'package:dartz/dartz.dart';

import '../../data/models/meal_model/meal_model.dart';

abstract class FavoriteRepo {
  Future<Either<String, List<MealModel>>> getFavoriteMeals();
  Future<Either<String, List<MealModel>>> addFavoriteMeal({
    required num carbs,
    required num protein,
    required num fat,
    required num calories,
    required String id,
    required String name,
  });
  Future<Either<String, List<MealModel>>> removeFavoriteMeal({
    required MealModel meal,
  });
}
