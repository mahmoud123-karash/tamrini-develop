import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:tamrini/core/api/dio_helper.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/services/upload_image.dart';
import 'package:tamrini/features/atricle/data/data_sources/remote_data_source/article_remote_data_source.dart';
import 'package:tamrini/features/atricle/data/models/article_model/article_model.dart';
import 'package:tamrini/core/models/notification_model/notification_model.dart';
import 'package:tamrini/features/atricle/domain/repo/article_repo.dart';
import 'package:uuid/uuid.dart';

class ArticleRepoImpl extends ArticleRepo {
  final ArticleRemoteDataSource articleRemoteDataSource;
  final DioHelper dioHelper;

  ArticleRepoImpl(this.articleRemoteDataSource, this.dioHelper);

  @override
  Future<Either<String, List<ArticleModel>>> getArticles() async {
    try {
      List<ArticleModel> list = await articleRemoteDataSource.getArticles();
      return right(list);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, List<ArticleModel>>> addArticle({
    required List<ArticleModel> list,
    required String title,
    required String body,
    required String imagePath,
  }) async {
    try {
      String uid = CacheHelper.getData(key: 'uid') ?? '';
      var uuid = const Uuid().v4();
      List files = [];
      files.add(File(imagePath));
      List<String> images = await uploadFiles(files: files);
      ArticleModel model = ArticleModel(
        date: Timestamp.now(),
        image: images,
        writerUid: uid,
        body: body,
        id: uuid,
        title: title,
        isPending: false,
        isRefused: false,
      );
      await FirebaseFirestore.instance
          .collection('articles')
          .doc('data')
          .collection('articles')
          .doc(uuid)
          .set(
            model.toJson(),
          );
      list.add(model);
      return right(list);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, List<ArticleModel>>> editArticle({
    required List<ArticleModel> list,
    required ArticleModel oldModel,
    required String title,
    required String body,
    required String imagePath,
  }) async {
    try {
      late ArticleModel model;
      if (imagePath == '') {
        model = ArticleModel(
          date: oldModel.date,
          image: oldModel.image,
          writerUid: oldModel.writerUid,
          body: body,
          id: oldModel.id,
          title: title,
          isPending: oldModel.isPending,
          isRefused: false,
        );
      } else {
        List files = [];
        files.add(File(imagePath));
        List<String> images = await uploadFiles(files: files);
        await deleteOldImages(
            newImages: images, oldImages: oldModel.image ?? []);
        model = ArticleModel(
          date: oldModel.date,
          image: images,
          writerUid: oldModel.writerUid,
          body: body,
          id: oldModel.id,
          title: title,
          isPending: oldModel.isPending,
          isRefused: false,
        );
      }
      await FirebaseFirestore.instance
          .collection('articles')
          .doc('data')
          .collection('articles')
          .doc(oldModel.id)
          .update(
            model.toJson(),
          );
      list.remove(oldModel);
      list.add(model);
      return right(list);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, List<ArticleModel>>> removeArticle({
    required List<ArticleModel> list,
    required ArticleModel oldModel,
  }) async {
    try {
      await FirebaseFirestore.instance
          .collection('articles')
          .doc('data')
          .collection('articles')
          .doc(oldModel.id)
          .delete();
      await deleteOldImages(newImages: [], oldImages: oldModel.image ?? []);
      list.remove(oldModel);
      return right(list);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, List<ArticleModel>>> banArticle({
    required bool isPending,
    required String articleId,
    required String writerUid,
  }) async {
    try {
      var data = await FirebaseFirestore.instance
          .collection('users')
          .doc(writerUid)
          .get();
      String token = data['token'] ?? '';
      await sendNotification(token, isPending, articleId, writerUid);
      await FirebaseFirestore.instance
          .collection('articles')
          .doc('data')
          .collection('articles')
          .doc(articleId)
          .update({
        "isPending": isPending,
        "isRefused": isPending,
      });
      List<ArticleModel> list = await articleRemoteDataSource.getArticles();
      return right(list);
    } catch (e) {
      return left(e.toString());
    }
  }

  Future<void> sendNotification(
    String token,
    bool isPending,
    String articleId,
    String writerUid,
  ) async {
    NotificationModel notification = NotificationModel(
      isReaden: false,
      subType: 'article',
      senderUid: adminUid,
      title: isPending == true ? 'ban_article' : 'no_ban_article',
      body: '',
      type: 'notification',
      uid: articleId,
      time: Timestamp.now(),
    );
    await FirebaseFirestore.instance
        .collection('notification')
        .doc(writerUid)
        .collection('data')
        .add(
          notification.toJson(),
        );
    if (token != '') {
      dioHelper.sendNotification(
        token: token,
        title: 'مقالاتك',
        body: isPending == false
            ? 'تم رفع التقييد عن المقال الخاص بك'
            : 'تم تقييد المقال الخاص بك',
        data: {
          "type": "notification",
          "subType": "article",
          "uid": articleId,
        },
      );
    }
  }
}
