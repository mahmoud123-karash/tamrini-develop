import 'package:tamrini/features/exercise/data/models/exercise_model/exercise_model.dart';

abstract class ExerciseStates {}

class InitialExerciseState extends ExerciseStates {}

class LoadingGetExerciseState extends ExerciseStates {}

class SucessGetExerciseState extends ExerciseStates {
  final List<ExerciseModel> exercises;

  SucessGetExerciseState(this.exercises);
}

class ErrorGetExerciseState extends ExerciseStates {
  final String message;

  ErrorGetExerciseState(this.message);
}
