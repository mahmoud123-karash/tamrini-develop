import 'package:dartz/dartz.dart';
import 'package:tamrini/features/gym/data/data_sources/remote_data_source/gym_remote_data_source.dart';
import 'package:tamrini/features/gym/data/models/gym_model/gym_model.dart';
import 'package:tamrini/features/gym/domain/repo/gym_repo.dart';

class GymRepoImpl extends GymRepo {
  final GymRemoteDataSource gymRemoteDataSource;

  GymRepoImpl(this.gymRemoteDataSource);

  @override
  Future<Either<String, List<GymModel>>> getGyms({
    required bool update,
  }) async {
    return await gymRemoteDataSource.getGyms(update: update);
  }

  @override
  Future<Either<String, List<GymModel>>> addGym() {
    // TODO: implement addGym
    throw UnimplementedError();
  }

  @override
  Future<Either<String, List<GymModel>>> editGym() {
    // TODO: implement editGym
    throw UnimplementedError();
  }

  @override
  Future<Either<String, List<GymModel>>> removeGym() {
    // TODO: implement removeGym
    throw UnimplementedError();
  }
}
