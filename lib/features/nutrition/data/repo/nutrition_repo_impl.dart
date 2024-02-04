import 'package:dartz/dartz.dart';
import 'package:tamrini/features/nutrition/data/data_source/remote_data_source/nutrition_remote_data_source.dart';
import 'package:tamrini/features/nutrition/data/models/nutrition_model/classification_model.dart';
import 'package:tamrini/features/nutrition/data/models/nutrition_model/nutrition_model.dart';
import 'package:tamrini/features/nutrition/domain/repo/nutrition_repo.dart';

class NutritionRepoImpl extends NuritionRepo {
  final NutritionRemoteDataSource nutritionRemoteDataSource;

  NutritionRepoImpl(this.nutritionRemoteDataSource);

  @override
  Future<Either<String, List<ClassificationModel>>> getClassifications() async {
    try {
      List<ClassificationModel> list =
          await nutritionRemoteDataSource.getClassifications();
      return right(list);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, List<NutritionModel>>> getNutritions({
    required String id,
  }) async {
    try {
      List<NutritionModel> list =
          await nutritionRemoteDataSource.getNutritions(id: id);
      return right(list);
    } catch (e) {
      return left(e.toString());
    }
  }
}
