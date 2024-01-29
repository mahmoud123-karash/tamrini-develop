import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/services/upload_image.dart';
import 'package:tamrini/features/store/data/data_sources/local_data_source/store_local_data_source.dart';
import 'package:tamrini/features/store/data/data_sources/remote_data_source/store_remote_data_source.dart';
import 'package:tamrini/features/store/data/models/category_model/category_model.dart';
import 'package:tamrini/features/store/data/models/store_model/store_model.dart';
import 'package:tamrini/features/store/domain/repo/store_repo.dart';

class StoreRepoImpl extends StoreRepo {
  final StoreRemoteDataSource storeRemoteDataSource;
  final StoreLocalDataSource storeLocalDataSource;
  StoreRepoImpl(this.storeRemoteDataSource, this.storeLocalDataSource);
  @override
  Future<Either<String, List<CategoryModel>>> getCategories() async {
    try {
      List<CategoryModel> cachedList = storeLocalDataSource.get();
      if (cachedList.isNotEmpty) {
        return right(cachedList);
      }
      List<CategoryModel> list = await storeRemoteDataSource.get();
      return right(list);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, List<StoreModel>>> getStores() async {
    try {
      List<StoreModel> list = await storeRemoteDataSource.getStores();
      return right(list);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, List<StoreModel>>> addStore({
    required String name,
    required String contact,
    required String imagePath,
  }) async {
    try {
      String uid = CacheHelper.getData(key: 'uid');
      List files = [];
      files.add(imagePath);
      List<String> images = await uploadFiles(files: files);
      StoreModel model = StoreModel(
        image: images.first,
        name: name,
        storeOwnerUid: uid,
        contact: contact,
        isBanned: false,
        products: [],
      );
      await FirebaseFirestore.instance
          .collection('stores')
          .doc(uid)
          .set(model.toMap());
      List<StoreModel> list = await storeRemoteDataSource.getStores();
      return right(list);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, List<StoreModel>>> editStore() {
    // TODO: implement editStore
    throw UnimplementedError();
  }

  @override
  Future<Either<String, List<StoreModel>>> addProduct() {
    // TODO: implement addStore
    throw UnimplementedError();
  }

  @override
  Future<Either<String, List<StoreModel>>> editProduct() {
    // TODO: implement editProduct
    throw UnimplementedError();
  }

  @override
  Future<Either<String, List<StoreModel>>> removeProduct() {
    // TODO: implement removeProduct
    throw UnimplementedError();
  }
}
