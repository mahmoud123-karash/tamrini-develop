import 'package:dartz/dartz.dart';
import 'package:tamrini/features/home_exercise/data/data_sources/remote_data_source/home_exercise_remote_data_source.dart';
import 'package:tamrini/features/home_exercise/data/models/home_exercise/home_exercise_model.dart';

import 'package:tamrini/features/home_exercise/domain/repo/home_exercise_repo.dart';

class HomeExerciseRepoImpl extends HomeExerciseRepo {
  final HomeExerciseRemoteDataSource homeExerciseRemoteDataSource;

  HomeExerciseRepoImpl(this.homeExerciseRemoteDataSource);
  @override
  Future<Either<String, List<HomeExerciseModel>>> get() async {
    try {
      List<HomeExerciseModel> list = await homeExerciseRemoteDataSource.get();
      return right(list);
    } catch (e) {
      return left(e.toString());
    }
  }
}
