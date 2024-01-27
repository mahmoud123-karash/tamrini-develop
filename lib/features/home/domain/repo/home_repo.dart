import 'package:dartz/dartz.dart';
import 'package:tamrini/features/home/data/models/gym_model/gym_model.dart';
import 'package:tamrini/features/home/data/models/store_model/store_model.dart';

abstract class HomeRepo {
  Future<Either<String, List<StoreModel>>> getStores();
  Future<Either<String, List<GymModel>>> getGyms({
    required bool update,
  });
}
