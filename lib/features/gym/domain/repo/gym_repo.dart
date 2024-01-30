import 'package:dartz/dartz.dart';
import 'package:tamrini/features/gym/data/models/gym_model/gym_model.dart';

abstract class GymRepo {
  Future<Either<String, List<GymModel>>> getGyms({
    required bool update,
  });

  Future<Either<String, List<GymModel>>> addGym({
    required List<String> paths,
    required String name,
    required String description,
    required int price,
    required double lat,
    required double long,
  });
  Future<Either<String, List<GymModel>>> editGym();
  Future<Either<String, List<GymModel>>> removeGym({
    required String id,
    required List<String> images,
  });
}
