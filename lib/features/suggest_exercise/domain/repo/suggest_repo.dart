import 'package:dartz/dartz.dart';
import 'package:tamrini/features/suggest_exercise/data/models/suggest_model/suggest_model.dart';

abstract class SuggestRepo {
  Future<Either<String, List<SuggestModel>>> getSuggestedExercises();
  Future<Either<String, String>> suggestExercise({
    required String title,
    required String imagePath,
  });
}
