import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:tamrini/core/services/upload_image.dart';
import 'package:tamrini/features/home/data/data_sources/remote_data_source/home_remote_data_source.dart';
import 'package:tamrini/features/home/data/models/article_model/article_model.dart';
import 'package:tamrini/features/home/data/models/exercise_model/data_model.dart';
import 'package:tamrini/features/home/data/models/exercise_model/exercise_model.dart';
import 'package:tamrini/features/home/data/models/gym_model/gym_model.dart';
import 'package:tamrini/features/home/data/models/store_model/store_model.dart';
import 'package:tamrini/features/home/domain/repo/home_repo.dart';

class HomeRepoImpl extends HomeRepo {
  final HomeRemoteDataSource homeRemoteDataSource;

  HomeRepoImpl(this.homeRemoteDataSource);
  @override
  Future<Either<String, List<ExerciseModel>>> getExercises() async {
    try {
      List<ExerciseModel> exercises = await homeRemoteDataSource.getExercises();
      return right(exercises);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, List<ArticleModel>>> getArticles() async {
    try {
      List<ArticleModel> list = await homeRemoteDataSource.getArticles();
      return right(list);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, List<StoreModel>>> getStores() async {
    try {
      List<StoreModel> list = await homeRemoteDataSource.getStores();
      return right(list);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, List<GymModel>>> getGyms({
    required bool update,
  }) async {
    return await homeRemoteDataSource.getGyms(update: update);
  }

  @override
  Future<Either<String, List<ExerciseModel>>> addSection({
    required List<ExerciseModel> list,
    required String title,
    required String id,
    required int order,
    required String imagePth,
  }) async {
    try {
      List paths = [];
      paths.add(File(imagePth));
      List<String> uris = await uploadFiles(files: paths);
      ExerciseModel model = ExerciseModel(
        data: [],
        order: order,
        title: title,
        image: uris.isNotEmpty ? uris.first : '',
        id: id,
      );
      await FirebaseFirestore.instance
          .collection('exercises')
          .doc('data')
          .collection('data')
          .add(
            model.toJson(),
          );
      list.add(model);
      return right(list);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, List<ExerciseModel>>> editSection({
    required List<ExerciseModel> list,
    required ExerciseModel oldModel,
    required String title,
    required int order,
    required String id,
    required String imagePth,
    required List<DataModel> data,
  }) async {
    try {
      late ExerciseModel newModel;
      if (imagePth != '') {
        List paths = [];
        paths.add(File(imagePth));
        List<String> images = await uploadFiles(files: paths);
        newModel = ExerciseModel(
          data: data,
          order: order,
          title: title,
          id: id,
          image: images.isEmpty ? '' : images.first,
        );
        List<String> newImages = [];
        List<String> oldImages = [];
        oldImages.add(oldModel.image!);
        newImages.add(images.first);
        await deleteOldImages(newImages: newImages, oldImages: oldImages);
      } else {
        newModel = ExerciseModel(
          data: data,
          order: order,
          title: title,
          id: id,
          image: oldModel.image,
        );
      }
      await FirebaseFirestore.instance
          .collection('exercises')
          .doc('data')
          .collection('data')
          .doc(id)
          .update(
            newModel.toJson(),
          );
      list.remove(oldModel);
      list.add(newModel);
      return right(list);
    } catch (e) {
      return left(e.toString());
    }
  }
}
