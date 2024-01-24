import 'package:tamrini/features/home_exercise/data/models/home_exercise/home_exercise_model.dart';

abstract class HomeExersiceStates {}

class InitialHomeExerciseState extends HomeExersiceStates {}

class LoadingGetHomeExerciseState extends HomeExersiceStates {}

class SucessGetHomeExerciseState extends HomeExersiceStates {
  final List<HomeExerciseModel> list;

  SucessGetHomeExerciseState(this.list);
}

class ErrorGetHomeExerciseState extends HomeExersiceStates {
  final String message;

  ErrorGetHomeExerciseState(this.message);
}
