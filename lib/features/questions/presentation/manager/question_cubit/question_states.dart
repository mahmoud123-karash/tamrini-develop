import '../../../data/models/question_model/question_model.dart';

abstract class QuestionStates {}

class InitialQuestionState extends QuestionStates {}

class LoadingGetQuestionsState extends QuestionStates {}

class SucessGetQuestionsState extends QuestionStates {
  final List<QuestionModel> list;

  SucessGetQuestionsState(this.list);
}

class ErrorGetQuestionsState extends QuestionStates {
  final String message;
  ErrorGetQuestionsState(this.message);
}
