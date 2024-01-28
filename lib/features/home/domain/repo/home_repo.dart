import 'package:dartz/dartz.dart';
import 'package:tamrini/features/home/data/models/gym_model/gym_model.dart';

abstract class HomeRepo {
  Future<Either<String, List<GymModel>>> getGyms({
    required bool update,
  });
}
