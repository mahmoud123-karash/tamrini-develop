abstract class AnswerStates {}

class InitialAnswerState extends AnswerStates {}

class LoadingAnswerState extends AnswerStates {}

class SucessUpdateAnswerState extends AnswerStates {}

class ErrorUpdateAnswerState extends AnswerStates {
  final String message;
  ErrorUpdateAnswerState(this.message);
}
