import 'package:dartz/dartz.dart';
import 'package:tamrini/features/home/data/data_sources/remote_data_source/home_remote_data_source.dart';
import 'package:tamrini/features/home/data/models/gym_model/gym_model.dart';
import 'package:tamrini/features/home/domain/repo/home_repo.dart';

class HomeRepoImpl extends HomeRepo {
  final HomeRemoteDataSource homeRemoteDataSource;

  HomeRepoImpl(this.homeRemoteDataSource);

  @override
  Future<Either<String, List<GymModel>>> getGyms({
    required bool update,
  }) async {
    return await homeRemoteDataSource.getGyms(update: update);
  }
}
