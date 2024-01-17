// ignore_for_file: file_names

import 'package:dartz/dartz.dart';
import 'package:tamrini/features/food/data/data_sources/remote_data_source/nutrition_remote_data_source.dart';
import 'package:tamrini/features/food/data/data_sources/remote_data_source/supplement_remote_data_source.dart';
import 'package:tamrini/features/food/data/models/nutrition_model.dart/classification_model.dart';
import 'package:tamrini/features/food/data/models/nutrition_model.dart/nutrition_model.dart';
import 'package:tamrini/features/food/data/models/supplement_model/supplement_model.dart';
import 'package:tamrini/features/food/domain/repo/food_repo.dart';

class FoodRepoImpl extends FoodRepo {
  final SupplementRemoteDataSource supplementRemoteDataSource;
  final NutritionRemoteDataSource nutritionRemoteDataSource;

  FoodRepoImpl(this.supplementRemoteDataSource, this.nutritionRemoteDataSource);
  @override
  Future<Either<String, List<SupplementModel>>> get() async {
    try {
      List<SupplementModel> list = await supplementRemoteDataSource.get();
      return right(list);
    } catch (e) {
      return left(e.toString());
    }
  }

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
