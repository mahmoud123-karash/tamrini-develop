abstract class QuestionStates {}

class InitialQuestionState extends QuestionStates {}

class LoadingAddQuestionState extends QuestionStates {}

class SucessAddQuestionState extends QuestionStates {}

class ErrorAddQuestionState extends QuestionStates {
  final String message;
  ErrorAddQuestionState(this.message);
}

class LoadingUpdateQuestionState extends QuestionStates {}

class SucessUpdateQuestionState extends QuestionStates {}

class ErrorUpdateQuestionState extends QuestionStates {
  final String message;
  ErrorUpdateQuestionState(this.message);
}

class LoadingRemoveQuestionState extends QuestionStates {}

class SucessRemoveQuestionState extends QuestionStates {}

class ErrorRemoveQuestionState extends QuestionStates {
  final String message;
  ErrorRemoveQuestionState(this.message);
}
