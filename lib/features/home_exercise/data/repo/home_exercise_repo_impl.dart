import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/services/upload_image.dart';
import 'package:tamrini/core/utils/check_assets_format.dart';
import 'package:tamrini/features/home_exercise/data/data_sources/remote_data_source/home_exercise_remote_data_source.dart';
import 'package:tamrini/features/home_exercise/data/models/home_exercise/exercise_data.dart';
import 'package:tamrini/features/home_exercise/data/models/home_exercise/home_exercise_model.dart';

import 'package:tamrini/features/home_exercise/domain/repo/home_exercise_repo.dart';
import 'package:uuid/uuid.dart';

class HomeExerciseRepoImpl extends HomeExerciseRepo {
  final HomeExerciseRemoteDataSource homeExerciseRemoteDataSource;

  HomeExerciseRepoImpl(this.homeExerciseRemoteDataSource);
  @override
  Future<Either<String, List<HomeExerciseModel>>> get() async {
    try {
      List<HomeExerciseModel> list = await homeExerciseRemoteDataSource.get();
      return right(list);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, List<HomeExerciseModel>>> addSection({
    required String name,
    required int order,
    required List<String> paths,
  }) async {
    try {
      List<String> images = await uploadPaths(paths);
      HomeExerciseModel model = HomeExerciseModel(
          data: [],
          order: order,
          title: name,
          image: images.isEmpty ? '' : images.first);
      FirebaseFirestore.instance
          .collection('homeExercises')
          .doc('data')
          .collection('data')
          .add(
            model.toJson(),
          );

      List<HomeExerciseModel> list = await homeExerciseRemoteDataSource.get();
      return right(list);
    } catch (e) {
      return left(e.toString());
    }
  }

  Future<List<String>> uploadPaths(List<String> paths) async {
    List files = [];
    for (var element in paths) {
      files.add(File(element));
    }
    List<String> images = await uploadFiles(files: files);
    return images;
  }

  @override
  Future<Either<String, List<HomeExerciseModel>>> editSection({
    required String name,
    required int order,
    required List<String> paths,
    required HomeExerciseModel section,
  }) async {
    try {
      late HomeExerciseModel model;
      if (paths.isEmpty) {
        model = HomeExerciseModel(
          data: section.data ?? [],
          order: order,
          title: name,
          image: section.image ?? '',
        );
      } else {
        List<String> images = await uploadPaths(paths);
        if (section.image != '') {
          List<String> oldImage = [];
          oldImage.add(section.image ?? "");
          await deleteOldImages(newImages: [], oldImages: oldImage);
        }
        model = HomeExerciseModel(
          data: section.data ?? [],
          order: order,
          title: name,
          image: images.isEmpty ? "" : images.first,
        );
      }

      FirebaseFirestore.instance
          .collection('homeExercises')
          .doc('data')
          .collection('data')
          .doc(section.id)
          .update(
            model.toJson(),
          );

      List<HomeExerciseModel> list = await homeExerciseRemoteDataSource.get();
      return right(list);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, List<HomeExerciseModel>>> addExercise({
    required String name,
    required String description,
    required String youtubUri,
    required List<String> paths,
    required HomeExerciseModel section,
  }) async {
    try {
      var id = const Uuid().v4();
      String uid = CacheHelper.getData(key: 'uid');

      List<String> images = await uploadPaths(paths);
      List<String> assets = [];
      assets.addAll([...images, youtubUri]);
      Data dataModel = Data(
        assets: assets,
        description: description,
        title: name,
        id: id,
        writerUid: uid,
      );
      List<Data> dataList = section.data ?? [];
      dataList.add(dataModel);
      HomeExerciseModel model = HomeExerciseModel(
        data: dataList,
        order: section.order,
        title: section.title,
        image: section.image ?? '',
      );
      FirebaseFirestore.instance
          .collection('homeExercises')
          .doc('data')
          .collection('data')
          .doc(section.id)
          .update(
            model.toJson(),
          );

      List<HomeExerciseModel> list = await homeExerciseRemoteDataSource.get();
      return right(list);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, List<HomeExerciseModel>>> removeExercise({
    required Data oldData,
    required HomeExerciseModel section,
  }) async {
    try {
      String image = checkImageformat(oldData.assets);
      List<String> oldImages = [];
      if (image != '') {
        oldImages.add(image);
        await deleteOldImages(newImages: [], oldImages: oldImages);
      }
      List<Data> dataList = section.data ?? [];
      dataList.remove(oldData);
      HomeExerciseModel model = HomeExerciseModel(
        data: dataList,
        order: section.order,
        title: section.title,
        image: section.image ?? '',
      );
      FirebaseFirestore.instance
          .collection('homeExercises')
          .doc('data')
          .collection('data')
          .doc(section.id)
          .update(
            model.toJson(),
          );

      List<HomeExerciseModel> list = await homeExerciseRemoteDataSource.get();
      return right(list);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, List<HomeExerciseModel>>> editExercise({
    required String name,
    required String description,
    required String youtubUri,
    required List<String> paths,
    required Data oldData,
    required HomeExerciseModel section,
  }) async {
    try {
      late Data dataModel;
      if (paths.isEmpty) {
        dataModel = Data(
          assets: oldData.assets,
          description: description,
          title: name,
          id: oldData.id,
          writerUid: oldData.writerUid,
        );
      } else {
        List<String> images = await uploadPaths(paths);
        List<String> assets = [];
        if (youtubUri != '') {
          assets.addAll([...images, youtubUri]);
        } else {
          String image = checkImageformat(oldData.assets);
          List<String> finalImages = oldData.assets;
          finalImages.remove(image);
          assets.addAll(images);
          assets.addAll(finalImages);
        }
        dataModel = Data(
          assets: assets,
          description: description,
          title: name,
          id: oldData.id,
          writerUid: oldData.writerUid,
        );
      }

      List<Data> dataList = section.data ?? [];
      dataList.add(dataModel);
      dataList.remove(oldData);
      HomeExerciseModel model = HomeExerciseModel(
        data: dataList,
        order: section.order,
        title: section.title,
        image: section.image ?? '',
      );
      FirebaseFirestore.instance
          .collection('homeExercises')
          .doc('data')
          .collection('data')
          .doc(section.id)
          .update(
            model.toJson(),
          );

      List<HomeExerciseModel> list = await homeExerciseRemoteDataSource.get();
      return right(list);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, List<HomeExerciseModel>>> moveExercise({
    required List<HomeExerciseModel> list,
    required HomeExerciseModel oldCategory,
    required HomeExerciseModel newCategory,
    required Data oldData,
  }) async {
    try {
      List<Data> oldDataList = oldCategory.data ?? [];
      oldDataList.remove(oldData);
      HomeExerciseModel oldModel = HomeExerciseModel(
        id: oldCategory.id,
        image: oldCategory.image,
        order: oldCategory.order,
        title: oldCategory.title,
        data: oldDataList,
      );
      await FirebaseFirestore.instance
          .collection('homeExercises')
          .doc('data')
          .collection('data')
          .doc(oldCategory.id)
          .update(
            oldModel.toJson(),
          );

      List<Data> newDataList = newCategory.data ?? [];
      newDataList.add(oldData);
      HomeExerciseModel newModel = HomeExerciseModel(
        id: newCategory.id,
        image: newCategory.image,
        order: newCategory.order,
        title: newCategory.title,
        data: newDataList,
      );
      await FirebaseFirestore.instance
          .collection('homeExercises')
          .doc('data')
          .collection('data')
          .doc(newCategory.id)
          .update(
            newModel.toJson(),
          );

      list.remove(newCategory);
      list.remove(oldCategory);
      list.add(newModel);
      list.add(oldModel);
      return right(list);
    } catch (e) {
      return left(e.toString());
    }
  }
}
