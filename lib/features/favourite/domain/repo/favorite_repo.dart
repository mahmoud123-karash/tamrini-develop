import 'package:dartz/dartz.dart';

import '../../data/models/meal_model/meal_model.dart';

abstract class FavoriteRepo {
  Future<Either<String, List<MealModel>>> getFavoriteMeals();
  Future<Either<String, List<MealModel>>> addFavoriteMeal({
    required MealModel meal,
  });
  Future<Either<String, List<MealModel>>> removeFavoriteMeal({
    required MealModel meal,
  });

  Future<Either<String, List<MealModel>>> editFavoriteMeal({
    required MealModel meal,
    required num wieght,
  });
}
