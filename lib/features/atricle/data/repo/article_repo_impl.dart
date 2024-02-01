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
      String type = CacheHelper.getData(key: 'usertype') ?? '';
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
        isPending: type == 'admin' ? false : true,
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
  Future<Either<String, List<ArticleModel>>> disPendingArticle({
    required List<ArticleModel> list,
    required ArticleModel oldModel,
    required bool isAcceped,
    required String token,
    required String title,
  }) async {
    try {
      ArticleModel model = ArticleModel(
        date: oldModel.date,
        image: oldModel.image,
        writerUid: oldModel.writerUid,
        body: oldModel.body,
        id: oldModel.id,
        title: oldModel.title,
        isPending: !isAcceped,
        isRefused: !isAcceped,
      );
      await sendNotification(
        token,
        isAcceped,
        oldModel,
        title,
        oldModel.title ?? '',
      );
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
      list.sort((a, b) => b.date!.compareTo(a.date!));
      return right(list);
    } catch (e) {
      return left(e.toString());
    }
  }

  Future<void> sendNotification(
    String token,
    bool isAcceped,
    ArticleModel oldModel,
    String title,
    String body,
  ) async {
    NotificationModel notification = NotificationModel(
      isReaden: false,
      subType: 'article',
      senderUid: adminUid,
      title: title,
      body: body,
      type: 'notification',
      uid: oldModel.id!,
      time: Timestamp.now(),
    );
    await FirebaseFirestore.instance
        .collection('notification')
        .doc(oldModel.writerUid)
        .collection('data')
        .add(
          notification.toJson(),
        );

    dioHelper.sendNotification(
      token: token,
      title: title == 'accept'
          ? 'تم قبول المقال الخاص بك'
          : title == 'refuse'
              ? 'تم رفض المقال الخاص بك'
              : 'تم تقييد المقال الخاص بك',
      body: body,
      data: {
        "type": "notification",
        "subType": "article",
        "uid": oldModel.id,
      },
    );
  }
}
