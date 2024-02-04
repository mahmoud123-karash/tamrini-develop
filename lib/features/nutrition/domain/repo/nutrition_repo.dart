import 'package:dartz/dartz.dart';
import 'package:tamrini/features/nutrition/data/models/nutrition_model/classification_model.dart';
import 'package:tamrini/features/nutrition/data/models/nutrition_model/nutrition_model.dart';

abstract class NuritionRepo {
  Future<Either<String, List<ClassificationModel>>> getClassifications();
  Future<Either<String, List<NutritionModel>>> getNutritions({
    required String id,
  });
}
