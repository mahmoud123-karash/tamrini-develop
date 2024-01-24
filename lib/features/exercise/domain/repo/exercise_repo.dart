import 'package:dartz/dartz.dart';
import 'package:tamrini/features/exercise/data/models/home_exercise/home_exercise_model.dart';
import 'package:tamrini/features/exercise/data/models/exercise_model/data_model.dart';
import 'package:tamrini/features/exercise/data/models/exercise_model/exercise_model.dart';

abstract class ExerciseRepo {
  Future<Either<String, List<HomeExerciseModel>>> get();

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
}
