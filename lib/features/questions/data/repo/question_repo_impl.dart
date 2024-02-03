import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/features/questions/data/models/question_model/question_model.dart';
import 'package:tamrini/features/questions/domain/repo/question_repo.dart';

import '../data_sources/remote_data_source/remote_question_data_source.dart';
import '../models/notification_model/notification_model.dart';

class QuestionRepoImpl extends QuestionRepo {
  final QuestionRemoteDataSource questionRemoteDataSource;

  QuestionRepoImpl(this.questionRemoteDataSource);

  @override
  Future<Either<String, List<QuestionModel>>> getQuestons() async {
    try {
      List<QuestionModel> list = await questionRemoteDataSource.get();
      return right(list);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, List<QuestionModel>>> addNewQuestion(
      {required String body}) async {
    QuestionModel model = QuestionModel(
      date: Timestamp.now(),
      body: body,
      askerUid: CacheHelper.getData(key: 'uid'),
      answersCount: 0,
      answers: [],
      isBanned: false,
    );
    try {
      await FirebaseFirestore.instance
          .collection('Q&A')
          .doc('questions')
          .collection('questions')
          .add(
            model.toJson(),
          );
      List<QuestionModel> list = await questionRemoteDataSource.get();
      return right(list);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, List<QuestionModel>>> removeQuestion(
      {required String id}) async {
    try {
      await FirebaseFirestore.instance
          .collection('Q&A')
          .doc('questions')
          .collection('questions')
          .doc(id)
          .delete();
      List<QuestionModel> list = await questionRemoteDataSource.get();
      return right(list);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, List<QuestionModel>>> updateQuestion(
      {required String id, required QuestionModel model}) async {
    try {
      await FirebaseFirestore.instance
          .collection('Q&A')
          .doc('questions')
          .collection('questions')
          .doc(id)
          .set(
            model.toJson(),
          );
      List<QuestionModel> list = await questionRemoteDataSource.get();
      return right(list);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  void setNotification({
    required String id,
    required String questionUid,
    required String body,
    required String title,
  }) async {
    String uid = CacheHelper.getData(key: 'uid');
    NotificationModel model = NotificationModel(
      senderUid: uid,
      title: title,
      body: body,
      isReaden: false,
      type: 'notification',
      subType: 'question',
      uid: questionUid,
      time: Timestamp.now(),
    );
    await FirebaseFirestore.instance
        .collection('notification')
        .doc(id)
        .collection('data')
        .add(
          model.toJson(),
        );
  }
}
