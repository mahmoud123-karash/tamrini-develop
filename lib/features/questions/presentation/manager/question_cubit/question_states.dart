abstract class QuestionStates {}

class InitialQuestionState extends QuestionStates {}

class LoadingAddQuestionState extends QuestionStates {}

class SucessAddQuestionState extends QuestionStates {
  SucessAddQuestionState();
}

class ErrorAddQuestionState extends QuestionStates {
  final String message;

  ErrorAddQuestionState(this.message);
}
