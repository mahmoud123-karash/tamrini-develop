import 'package:dartz/dartz.dart';
import 'package:tamrini/features/exercise/data/data_sources/remote_data_source/exercise_remote_data_source.dart';
import 'package:tamrini/features/exercise/data/models/home_exercise/home_exercise_model.dart';
import 'package:tamrini/features/exercise/domain/repo/exercise_repo.dart';

class ExerciseRepoImpl extends ExerciseRepo {
  final ExerciseRemoteDataSource exerciseRemoteDataSource;

  ExerciseRepoImpl(this.exerciseRemoteDataSource);
  @override
  Future<Either<String, List<HomeExerciseModel>>> get() async {
    try {
      List<HomeExerciseModel> list = await exerciseRemoteDataSource.get();
      return right(list);
    } catch (e) {
      return left(e.toString());
    }
  }
}
