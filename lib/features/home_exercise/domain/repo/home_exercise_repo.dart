import 'package:dartz/dartz.dart';
import 'package:tamrini/features/home_exercise/data/models/home_exercise/exercise_data.dart';
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

  Future<Either<String, List<HomeExerciseModel>>> addExercise({
    required String name,
    required String description,
    required String youtubUri,
    required List<String> paths,
    required HomeExerciseModel section,
  });

  Future<Either<String, List<HomeExerciseModel>>> editExercise({
    required String name,
    required String description,
    required String youtubUri,
    required List<String> paths,
    required Data oldData,
    required HomeExerciseModel section,
  });
  Future<Either<String, List<HomeExerciseModel>>> removeExercise({
    required Data oldData,
    required HomeExerciseModel section,
  });

  Future<Either<String, List<HomeExerciseModel>>> moveExercise({
    required List<HomeExerciseModel> list,
    required HomeExerciseModel oldCategory,
    required HomeExerciseModel newCategory,
    required Data oldData,
  });
}
