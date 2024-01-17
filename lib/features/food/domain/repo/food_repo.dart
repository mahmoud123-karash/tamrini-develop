import 'package:dartz/dartz.dart';
import 'package:tamrini/features/food/data/models/nutrition_model.dart/classification_model.dart';
import 'package:tamrini/features/food/data/models/nutrition_model.dart/nutrition_model.dart';
import 'package:tamrini/features/food/data/models/supplement_model/supplement_model.dart';

abstract class FoodRepo {
  Future<Either<String, List<SupplementModel>>> get();
  Future<Either<String, List<ClassificationModel>>> getClassifications();
  Future<Either<String, List<NutritionModel>>> getNutritions({
    required String id,
  });
}
