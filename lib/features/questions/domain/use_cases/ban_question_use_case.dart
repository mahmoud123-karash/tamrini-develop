import 'package:dartz/dartz.dart';
import 'package:tamrini/core/api/dio_helper.dart';
import 'package:tamrini/features/questions/data/data_sources/remote_data_source/remote_question_data_source.dart';
import 'package:tamrini/features/questions/data/models/question_model/question_model.dart';
import 'package:tamrini/features/questions/domain/repo/question_repo.dart';

abstract class UseCase {
  Future<Either<String, List<QuestionModel>>> ban({
    required QuestionModel model,
    required String id,
    required String token,
  });
}

class BanQuestionUseCase extends UseCase {
  final QuestionRepo questionRepo;
  final DioHelper dioHelper;
  final QuestionRemoteDataSource questionRemoteDataSource;

  BanQuestionUseCase(
      this.questionRepo, this.dioHelper, this.questionRemoteDataSource);
  @override
  Future<Either<String, List<QuestionModel>>> ban({
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
          title: 'الإسئلة',
          body: 'تم تقييد سؤالك',
          data: {
            "type": "notification",
            "subType": "question",
            "uid": id,
          },
        );
      }
      List<QuestionModel> list = await questionRemoteDataSource.get();
      return right(list);
    } catch (e) {
      return left(e.toString());
    }
  }
}
