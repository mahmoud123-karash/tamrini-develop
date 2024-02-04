import 'package:dartz/dartz.dart';
import 'package:tamrini/features/food/data/models/supplement_model/supplement_data.dart';
import 'package:tamrini/features/food/data/models/supplement_model/supplement_model.dart';

abstract class FoodRepo {
  Future<Either<String, List<SupplementModel>>> get();
  Future<Either<String, List<SupplementModel>>> addCategory({
    required String imagePath,
    required String title,
  });
  Future<Either<String, List<SupplementModel>>> editCategory({
    required String imagePath,
    required String title,
    required SupplementModel oldModel,
  });

  Future<Either<String, List<SupplementModel>>> removeCategory({
    required SupplementModel oldModel,
  });

  Future<Either<String, List<SupplementModel>>> addSupplement({
    required SupplementModel category,
    required String imagePath,
    required String title,
    required String description,
  });
  Future<Either<String, List<SupplementModel>>> editSupplement({
    required SupplementData oldModel,
    required SupplementModel category,
    required String imagePath,
    required String title,
    required String description,
  });
  Future<Either<String, List<SupplementModel>>> removeSupplement({
    required SupplementData oldModel,
    required SupplementModel category,
  });
}
