import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/features/questions/data/data_sources/remote_data_source/user_remote_data_source.dart';
import 'package:tamrini/features/questions/data/models/question_model/question_model.dart';
import 'package:tamrini/features/questions/data/models/user_model/user_model.dart';
import 'package:tamrini/features/questions/domain/repo/question_repo.dart';

import '../models/notification_model/notification_model.dart';

class QuestionRepoImpl extends QuestionRepo {
  final UserRemoteDataSource userRemoteDataSource;

  QuestionRepoImpl(this.userRemoteDataSource);
  @override
  Future<Either<String, UserModel>> getUser({required String uid}) async {
    try {
      UserModel model = await userRemoteDataSource.get(uid: uid);
      return right(model);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, String>> addNewQuestion({required String body}) async {
    QuestionModel model = QuestionModel(
      date: Timestamp.now(),
      body: body,
      askerUid: CacheHelper.getData(key: 'uid'),
      answersCount: 0,
      answers: [],
      isBanned: false,
    );
    try {
      var result = await FirebaseFirestore.instance
          .collection('Q&A')
          .doc('questions')
          .collection('questions')
          .add(
            model.toJson(),
          );
      return right(result.id);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, String>> removeQuestion({required String id}) async {
    try {
      await FirebaseFirestore.instance
          .collection('Q&A')
          .doc('questions')
          .collection('questions')
          .doc(id)
          .delete();
      return right('removed');
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, String>> updateQuestion(
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
      return right('updated');
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
