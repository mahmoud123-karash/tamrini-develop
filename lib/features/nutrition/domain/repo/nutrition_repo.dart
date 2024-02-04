import 'package:dartz/dartz.dart';
import 'package:tamrini/features/nutrition/data/models/nutrition_model/classification_model.dart';
import 'package:tamrini/features/nutrition/data/models/nutrition_model/nutrition_model.dart';

abstract class NuritionRepo {
  Future<Either<String, List<ClassificationModel>>> getClassifications();
  Future<Either<String, List<ClassificationModel>>> addClassifications({
    required String name,
  });
  Future<Either<String, List<ClassificationModel>>> editClassifications({
    required String name,
    required String id,
  });
  Future<Either<String, List<NutritionModel>>> getNutritions({
    required String id,
  });
  Future<Either<String, List<NutritionModel>>> addNutrition({
    required String categoryId,
    required String name,
    required double protien,
    required double fat,
    required double carb,
    required double calories,
  });
  Future<Either<String, List<NutritionModel>>> editNutrition({
    required String categoryId,
    required String id,
    required String name,
    required double protien,
    required double fat,
    required double carb,
    required double calories,
  });
  Future<Either<String, List<NutritionModel>>> removeNutrition({
    required String categoryId,
    required String id,
  });
}
