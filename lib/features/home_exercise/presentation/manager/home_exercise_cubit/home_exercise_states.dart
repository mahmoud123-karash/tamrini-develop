import 'package:tamrini/features/home_exercise/data/models/home_exercise/home_exercise_model.dart';

abstract class HomeExerciseStates {}

class InitialHomeExerciseState extends HomeExerciseStates {}

class LoadingGetHomeExerciseState extends HomeExerciseStates {}

class SucessGetHomeExerciseState extends HomeExerciseStates {
  final List<HomeExerciseModel> list;

  SucessGetHomeExerciseState(this.list);
}

class ErrorGetHomeExerciseState extends HomeExerciseStates {
  final String message;

  ErrorGetHomeExerciseState(this.message);
}
