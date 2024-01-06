import 'package:dartz/dartz.dart';
import 'package:tamrini/features/store/data/data_sources/local_data_source/store_local_data_source.dart';
import 'package:tamrini/features/store/data/data_sources/remote_data_source/store_remote_data_source.dart';
import 'package:tamrini/features/store/data/models/category_model.dart';
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
}
