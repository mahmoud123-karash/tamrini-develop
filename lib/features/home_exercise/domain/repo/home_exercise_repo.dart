import 'package:dartz/dartz.dart';
import 'package:tamrini/features/home_exercise/data/models/home_exercise/home_exercise_model.dart';

abstract class HomeExerciseRepo {
  Future<Either<String, List<HomeExerciseModel>>> get();
  Future<Either<String, List<HomeExerciseModel>>> addSection({
    required String name,
    required int order,
    required List<String> paths,
  });
  Future<Either<String, List<HomeExerciseModel>>> editSection({
    required String name,
    required int order,
    required List<String> paths,
    required HomeExerciseModel section,
  });
}
