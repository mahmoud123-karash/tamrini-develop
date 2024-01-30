import 'package:dartz/dartz.dart';
import 'package:tamrini/features/gym/data/models/gym_model/gym_model.dart';

abstract class GymRepo {
  Future<Either<String, List<GymModel>>> getGyms({
    required bool update,
  });

  Future<Either<String, List<GymModel>>> addGym();
  Future<Either<String, List<GymModel>>> editGym();
  Future<Either<String, List<GymModel>>> removeGym();
}
