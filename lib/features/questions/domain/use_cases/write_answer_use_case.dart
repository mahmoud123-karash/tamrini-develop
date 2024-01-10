import 'package:tamrini/features/questions/data/models/question_model/question_model.dart';

abstract class UseCase {
  void answer({
    required String answer,
    required QuestionModel model,
  });
}

class WriteAnswerUseCase extends UseCase {
  @override
  void answer({required String answer, required QuestionModel model}) {}
}
