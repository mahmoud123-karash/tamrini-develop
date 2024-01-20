import 'package:dartz/dartz.dart';
import 'package:tamrini/features/diet_food/data/models/diet_food_model.dart/diet_food_model.dart';

abstract class DietFoodRepo {
  Future<Either<String, List<DietFoodModel>>> get();
}