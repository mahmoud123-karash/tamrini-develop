import 'package:dartz/dartz.dart';
import 'package:tamrini/features/store/data/models/category_model/category_model.dart';
import 'package:tamrini/features/store/data/models/store_model/store_model.dart';

abstract class StoreRepo {
  Future<Either<String, List<CategoryModel>>> getCategories();
  Future<Either<String, List<StoreModel>>> getStores();
}
