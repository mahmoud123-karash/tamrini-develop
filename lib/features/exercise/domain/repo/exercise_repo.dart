import 'package:dartz/dartz.dart';
import 'package:tamrini/features/exercise/data/models/home_exercise/home_exercise_model.dart';

abstract class ExerciseRepo {
  Future<Either<String, List<HomeExerciseModel>>> get();
}
