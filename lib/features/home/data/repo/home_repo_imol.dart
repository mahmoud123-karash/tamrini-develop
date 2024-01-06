import 'package:dartz/dartz.dart';
import 'package:tamrini/features/home/data/data_sources/remote_data_source/home_remote_data_source.dart';
import 'package:tamrini/features/home/data/models/article_model/article_model.dart';
import 'package:tamrini/features/home/data/models/exercise_model/exercise_model.dart';
import 'package:tamrini/features/home/data/models/gym_model/gym_model.dart';
import 'package:tamrini/features/home/data/models/store_model/store_model.dart';
import 'package:tamrini/features/home/domain/repo/home_repo.dart';

class HomeRepoImpl extends HomeRepo {
  final HomeRemoteDataSource homeRemoteDataSource;

  HomeRepoImpl(this.homeRemoteDataSource);
  @override
  Future<Either<String, List<ExerciseModel>>> getExercises() async {
    try {
      List<ExerciseModel> exercises = await homeRemoteDataSource.getExercises();
      return right(exercises);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, List<ArticleModel>>> getArticles() async {
    try {
      List<ArticleModel> list = await homeRemoteDataSource.getArticles();
      return right(list);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, List<StoreModel>>> getStores() async {
    try {
      List<StoreModel> list = await homeRemoteDataSource.getStores();
      return right(list);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, List<GymModel>>> getGyms({
    required bool update,
  }) async {
    return await homeRemoteDataSource.getGyms(update: update);
  }
}
