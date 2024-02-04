import 'package:dartz/dartz.dart';
import 'package:tamrini/features/diet_food/data/models/diet_food_model.dart/diet_food_model.dart';

abstract class DietFoodRepo {
  Future<Either<String, List<DietFoodModel>>> get();
  Future<Either<String, List<DietFoodModel>>> addMeal({
    required String name,
    required String description,
    required List<String> paths,
  });
  Future<Either<String, List<DietFoodModel>>> editMeal({
    required String name,
    required String description,
    required List<String> paths,
    required DietFoodModel oldModel,
  });
  Future<Either<String, List<DietFoodModel>>> removeMeal({
    required String id,
    required List<String> assets,
  });
}
