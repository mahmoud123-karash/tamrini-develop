import 'package:dartz/dartz.dart';
import 'package:tamrini/features/store/data/models/category_model/category_model.dart';
import 'package:tamrini/features/store/data/models/store_model/product_model.dart';
import 'package:tamrini/features/store/data/models/store_model/store_model.dart';

abstract class StoreRepo {
  Future<Either<String, List<CategoryModel>>> getCategories();
  Future<Either<String, List<StoreModel>>> getStores();
  Future<Either<String, List<StoreModel>>> addStore({
    required String name,
    required String contact,
    required String imagePath,
  });
  Future<Either<String, List<StoreModel>>> editStore({
    required String name,
    required String contact,
    required String imagePath,
    required StoreModel store,
  });
  Future<Either<String, List<StoreModel>>> addProduct({
    required String title,
    required String description,
    required String type,
    required num price,
    required num oldPrice,
    required bool bestSeller,
    required String imagePath,
    required StoreModel store,
  });
  Future<Either<String, List<StoreModel>>> editProduct({
    required String title,
    required String description,
    required String type,
    required num price,
    required num oldPrice,
    required bool bestSeller,
    required bool available,
    required String imagePath,
    required StoreModel store,
    required ProductModel oldModel,
  });
  Future<Either<String, List<StoreModel>>> removeProduct({
    required ProductModel oldModel,
    required StoreModel store,
  });

  Future<Either<String, List<StoreModel>>> banStore({
    required StoreModel store,
  });
}
