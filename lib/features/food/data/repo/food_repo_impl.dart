// ignore_for_file: file_names

import 'package:dartz/dartz.dart';
import 'package:tamrini/features/food/data/data_sources/remote_data_source/supplement_remote_data_source.dart';
import 'package:tamrini/features/food/data/models/supplement_model/supplement_model.dart';
import 'package:tamrini/features/food/domain/repo/food_repo.dart';

class FoodRepoImpl extends FoodRepo {
  final SupplementRemoteDataSource supplementRemoteDataSource;

  FoodRepoImpl(this.supplementRemoteDataSource);
  @override
  Future<Either<String, List<SupplementModel>>> get() async {
    try {
      List<SupplementModel> list = await supplementRemoteDataSource.get();
      return right(list);
    } catch (e) {
      return left(e.toString());
    }
  }
}
