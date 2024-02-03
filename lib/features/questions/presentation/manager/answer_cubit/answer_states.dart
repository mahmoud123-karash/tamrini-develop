abstract class AnswerStates {}

class InitialAnswerState extends AnswerStates {}

class LoadingAddAnswerState extends AnswerStates {}

class SucessAddAnswerState extends AnswerStates {}

class ErrorAddAnswerState extends AnswerStates {
  final String message;
  ErrorAddAnswerState(this.message);
}

class LoadingUpdateAnswerState extends AnswerStates {}

class SucessUpdateAnswerState extends AnswerStates {}

class SucessRemoveAnswerState extends AnswerStates {}


class ErrorUpdateAnswerState extends AnswerStates {
  final String message;
  ErrorUpdateAnswerState(this.message);
}
