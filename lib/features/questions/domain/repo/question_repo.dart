import 'package:dartz/dartz.dart';
import 'package:tamrini/features/questions/data/models/question_model/question_model.dart';
import 'package:tamrini/features/questions/data/models/user_model/user_model.dart';

abstract class QuestionRepo {
  Future<Either<String, UserModel>> getUser({required String uid});
  Future<Either<String, String>> addNewQuestion({required String body});
  Future<Either<String, String>> updateQuestion(
      {required String id, required QuestionModel model});
  Future<Either<String, String>> removeQuestion({required String id});
  void setNotification({
    required String id,
    required String questionUid,
    required String body,
  });
}
