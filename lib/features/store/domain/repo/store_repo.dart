import 'package:dartz/dartz.dart';
import 'package:tamrini/features/store/data/models/category_model.dart';

abstract class StoreRepo {
  Future<Either<String, List<CategoryModel>>> getCategories();
}
