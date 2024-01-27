import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/services/upload_image.dart';
import 'package:tamrini/features/atricle/data/data_sources/remote_data_source/article_remote_data_source.dart';
import 'package:tamrini/features/atricle/data/models/article_model/article_model.dart';
import 'package:tamrini/features/atricle/domain/repo/article_repo.dart';
import 'package:uuid/uuid.dart';

class ArticleRepoImpl extends ArticleRepo {
  final ArticleRemoteDataSource articleRemoteDataSource;

  ArticleRepoImpl(this.articleRemoteDataSource);

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
  }) async {
    try {
      ArticleModel model = ArticleModel(
        date: oldModel.date,
        image: oldModel.image,
        writerUid: oldModel.writerUid,
        body: oldModel.body,
        id: oldModel.id,
        title: oldModel.title,
        isPending: false,
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
      return right(list);
    } catch (e) {
      return left(e.toString());
    }
  }
}
