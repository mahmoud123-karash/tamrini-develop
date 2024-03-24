import 'package:dartz/dartz.dart';
import 'package:tamrini/features/questions/data/models/question_model/question_model.dart';

abstract class QuestionRepo {
  Future<Either<String, List<QuestionModel>>> getQuestons();
  Future<Either<String, List<QuestionModel>>> addNewQuestion({
    required String body,
  });
  Future<Either<String, List<QuestionModel>>> updateQuestion({
    required String id,
    required QuestionModel model,
  });
  Future<Either<String, List<QuestionModel>>> removeQuestion(
      {required String id});

  void setNotification({
    required String id,
    required String questionUid,
    required String body,
    required String title,
  });
}
