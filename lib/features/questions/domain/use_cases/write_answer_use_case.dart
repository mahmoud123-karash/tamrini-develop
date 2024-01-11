import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:tamrini/core/api/dio_helper.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/features/questions/data/models/question_model/answer_model.dart';
import 'package:tamrini/features/questions/data/models/question_model/question_model.dart';
import 'package:tamrini/features/questions/domain/repo/question_repo.dart';

abstract class UseCase {
  Future<Either<String, String>> answer({
    required String answer,
    required QuestionModel model,
    required String id,
    required String token,
  });
}

class WriteAnswerUseCase extends UseCase {
  final QuestionRepo questionRepo;
  final DioHelper dioHelper;

  WriteAnswerUseCase(this.questionRepo, this.dioHelper);
  @override
  Future<Either<String, String>> answer({
    required String answer,
    required QuestionModel model,
    required String id,
    required String token,
  }) async {
    String uid = CacheHelper.getData(key: 'uid');
    AnswerModel aModel = AnswerModel(
      date: Timestamp.now(),
      answer: answer,
      userUid: uid,
    );
    try {
      List<AnswerModel> list = model.answers;
      list.add(aModel);
      QuestionModel question = QuestionModel(
        date: model.date,
        body: model.body,
        askerUid: model.askerUid,
        answersCount: model.answersCount + 1,
        answers: list,
        isBanned: model.isBanned,
      );
      await questionRepo.updateQuestion(id: id, model: question);
      if (model.askerUid != uid) {
        questionRepo.setNotification(
            id: model.askerUid, questionUid: id, body: answer);
        dioHelper.sendNotification(
            token: token, title: 'إجابة جديدة على سؤالك', body: answer);
      }
      return right('');
    } catch (e) {
      return left(e.toString());
    }
  }
}
