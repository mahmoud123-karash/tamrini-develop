import 'package:dartz/dartz.dart';
import 'package:tamrini/features/store/data/models/category_model/category_model.dart';
import 'package:tamrini/features/store/data/models/store_model/store_model.dart';

abstract class StoreRepo {
  Future<Either<String, List<CategoryModel>>> getCategories();
  Future<Either<String, List<StoreModel>>> getStores();
  Future<Either<String, List<StoreModel>>> addStore({
    required String name,
    required String contact,
    required String imagePath,
  });
  Future<Either<String, List<StoreModel>>> editStore();
  Future<Either<String, List<StoreModel>>> addProduct();
  Future<Either<String, List<StoreModel>>> editProduct();
  Future<Either<String, List<StoreModel>>> removeProduct();
}
