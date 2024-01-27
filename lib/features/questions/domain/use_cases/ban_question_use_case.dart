import 'package:dartz/dartz.dart';
import 'package:tamrini/core/api/dio_helper.dart';
import 'package:tamrini/features/questions/data/models/question_model/question_model.dart';
import 'package:tamrini/features/questions/domain/repo/question_repo.dart';

abstract class UseCase {
  Future<Either<String, String>> ban({
    required QuestionModel model,
    required String id,
    required String token,
  });
}

class BanQuestionUseCase extends UseCase {
  final QuestionRepo questionRepo;
  final DioHelper dioHelper;

  BanQuestionUseCase(this.questionRepo, this.dioHelper);
  @override
  Future<Either<String, String>> ban({
    required QuestionModel model,
    required String id,
    required String token,
  }) async {
    try {
      QuestionModel question = QuestionModel(
        date: model.date,
        body: model.body,
        askerUid: model.askerUid,
        answersCount: model.answersCount,
        answers: model.answers,
        isBanned: true,
      );
      await questionRepo.updateQuestion(id: id, model: question);
      questionRepo.setNotification(
        id: model.askerUid,
        questionUid: id,
        title: 'ban_question',
        body: '',
      );
      if (token != '') {
        dioHelper.sendNotification(
          token: token,
          title: 'تم تقييد سؤالك',
          body: '',
          data: {
            "type": "notification",
            "subType": "question",
            "uid": id,
          },
        );
      }

      return right('');
    } catch (e) {
      return left(e.toString());
    }
  }
}
