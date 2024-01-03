import 'package:dartz/dartz.dart';
import 'package:tamrini/features/home/data/models/exercise_model/exercise_model.dart';

abstract class HomeRepo {
  Future<Either<String, List<ExerciseModel>>> getExercises();
}
