import 'package:dartz/dartz.dart';
import 'package:tamrini/features/home_exercise/data/models/home_exercise/home_exercise_model.dart';

abstract class HomeExerciseRepo {
  Future<Either<String, List<HomeExerciseModel>>> get();
}
