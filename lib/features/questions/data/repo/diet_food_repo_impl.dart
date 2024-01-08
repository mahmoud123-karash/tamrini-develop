import 'package:dartz/dartz.dart';
import 'package:tamrini/features/questions/data/data_sources/remote_data_source/diet_food_remote_data_source.dart';
import 'package:tamrini/features/questions/data/models/diet_food_model.dart/diet_food_model.dart';
import 'package:tamrini/features/questions/domain/repo/diet_food_repo.dart';

class DietFoodRepoImpl extends DietFoodRepo {
  final DietFoodRemoteDataSource dietFoodRemoteDataSource;

  DietFoodRepoImpl(this.dietFoodRemoteDataSource);
  @override
  Future<Either<String, List<DietFoodModel>>> get() async {
    try {
      List<DietFoodModel> list = await dietFoodRemoteDataSource.get();

      return right(list);
    } catch (e) {
      return left(e.toString());
    }
  }
}
