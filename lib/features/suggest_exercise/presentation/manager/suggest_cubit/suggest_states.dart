import 'package:tamrini/features/suggest_exercise/data/models/suggest_model/suggest_model.dart';

abstract class SuggestStates {}

class InitialSuggestState extends SuggestStates {}

class LoadingSuggestState extends SuggestStates {}

class SucessSuggestState extends SuggestStates {}

class ErrorSuggestState extends SuggestStates {
  final String message;
  ErrorSuggestState(this.message);
}

class LoadingGetSuggestedExercisesState extends SuggestStates {}

class SucessGetSuggestedExercisesState extends SuggestStates {
  final List<SuggestModel> list;
  SucessGetSuggestedExercisesState(this.list);
}

class ErrorGetSuggestedExercisestate extends SuggestStates {
  final String message;
  ErrorGetSuggestedExercisestate(this.message);
}
