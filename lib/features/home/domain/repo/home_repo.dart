import 'package:dartz/dartz.dart';
import 'package:tamrini/features/home/data/models/article_model/article_model.dart';
import 'package:tamrini/features/home/data/models/exercise_model/exercise_model.dart';

abstract class HomeRepo {
  Future<Either<String, List<ExerciseModel>>> getExercises();
  Future<Either<String, List<ArticleModel>>> getArticles();
}
