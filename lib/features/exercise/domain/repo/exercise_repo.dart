import 'package:dartz/dartz.dart';
import 'package:tamrini/features/exercise/data/models/exercise_model/data_model.dart';
import 'package:tamrini/features/exercise/data/models/exercise_model/exercise_model.dart';

abstract class ExerciseRepo {
  Future<Either<String, List<ExerciseModel>>> getExercises();
  Future<Either<String, List<ExerciseModel>>> addSection({
    required List<ExerciseModel> list,
    required String title,
    required int order,
    required String imagePth,
  });
  Future<Either<String, List<ExerciseModel>>> editSection({
    required List<ExerciseModel> list,
    required ExerciseModel oldModel,
    required String title,
    required int order,
    required String id,
    required String imagePth,
    required List<DataModel> data,
  });

  Future<Either<String, List<ExerciseModel>>> addExercise({
    required List<ExerciseModel> list,
    required ExerciseModel exercise,
    required String title,
    required String description,
    required String youtubUrl,
    required String imagePath,
  });

  Future<Either<String, List<ExerciseModel>>> editExercise({
    required List<ExerciseModel> list,
    required ExerciseModel exercise,
    required String title,
    required String description,
    required String youtubUrl,
    required String imagePath,
    required DataModel oldData,
  });

  Future<Either<String, List<ExerciseModel>>> removeExercise({
    required ExerciseModel exercise,
    required DataModel oldData,
  });
}
