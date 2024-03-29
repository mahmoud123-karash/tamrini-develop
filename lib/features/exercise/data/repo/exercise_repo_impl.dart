import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/services/upload_image.dart';
import 'package:tamrini/core/utils/check_assets_format.dart';
import 'package:tamrini/features/exercise/data/data_sources/remote_data_source/exercise_remote_data_source.dart';
import 'package:tamrini/features/exercise/domain/repo/exercise_repo.dart';
import 'package:tamrini/features/exercise/data/models/exercise_model/data_model.dart';
import 'package:tamrini/features/exercise/data/models/exercise_model/exercise_model.dart';
import 'package:uuid/uuid.dart';

class ExerciseRepoImpl extends ExerciseRepo {
  final ExerciseRemoteDataSource exerciseRemoteDataSource;

  ExerciseRepoImpl(this.exerciseRemoteDataSource);

  @override
  Future<Either<String, List<ExerciseModel>>> getExercises() async {
    try {
      List<ExerciseModel> exercises =
          await exerciseRemoteDataSource.getExercises();
      return right(exercises);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, List<ExerciseModel>>> addSection({
    required List<ExerciseModel> list,
    required String title,
    required int order,
    required String imagePth,
  }) async {
    try {
      List paths = [];
      paths.add(File(imagePth));
      List<String> uris = await uploadFiles(files: paths);
      var uuid = const Uuid().v4();
      ExerciseModel model = ExerciseModel(
        data: [],
        order: order,
        title: title,
        image: uris.isNotEmpty ? uris.first : '',
        id: uuid,
      );
      await FirebaseFirestore.instance
          .collection('exercises')
          .doc('data')
          .collection('data')
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
        if (oldModel.image != '') {
          List<String> oldImages = [];
          oldImages.add(oldModel.image!);
          await deleteOldImages(newImages: images, oldImages: oldImages);
        }
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

  @override
  Future<Either<String, List<ExerciseModel>>> addExercise({
    required List<ExerciseModel> list,
    required ExerciseModel exercise,
    required String title,
    required String description,
    required String youtubUrl,
    required String imagePath,
  }) async {
    try {
      String uid = CacheHelper.getData(key: 'uid') ?? "";
      List files = [];
      files.add(File(imagePath));
      List<String> images = await uploadFiles(files: files);
      List<DataModel> dataList = exercise.data ?? [];
      var id = const Uuid().v4();
      List<String> assets = [];
      assets.addAll([...images, youtubUrl]);
      DataModel data = DataModel(
        writerUid: uid,
        id: id,
        description: description,
        title: title,
        assets: assets,
      );
      dataList.add(data);
      ExerciseModel model = ExerciseModel(
        id: exercise.id,
        image: exercise.image,
        order: exercise.order,
        title: exercise.title,
        data: dataList,
      );
      await FirebaseFirestore.instance
          .collection('exercises')
          .doc('data')
          .collection('data')
          .doc(exercise.id)
          .update(
            model.toJson(),
          );
      list.remove(exercise);
      list.add(model);
      return right(list);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, List<ExerciseModel>>> editExercise({
    required List<ExerciseModel> list,
    required ExerciseModel exercise,
    required String title,
    required String description,
    required String youtubUrl,
    required String imagePath,
    required DataModel oldData,
  }) async {
    try {
      String uid = CacheHelper.getData(key: 'uid') ?? '';

      List<DataModel> dataList = exercise.data ?? [];
      late DataModel newData;
      if (imagePath == '') {
        List<String> assets = [];
        if (checkImageformat(oldData.assets ?? []) != '') {
          assets.add(checkImageformat(oldData.assets ?? []));
        }
        assets.add(youtubUrl);
        newData = DataModel(
          writerUid: uid,
          id: oldData.id,
          description: description,
          title: title,
          assets: assets,
        );
      } else {
        List files = [];
        files.add(File(imagePath));
        List<String> images = await uploadFiles(files: files);
        if (checkImageformat(oldData.assets ?? []) != '') {
          List<String> oldImages = [];
          oldImages.add(checkImageformat(oldData.assets ?? []));
          await deleteOldImages(newImages: images, oldImages: oldImages);
        }
        List<String> assets = [];
        assets.addAll([...images, youtubUrl]);
        newData = DataModel(
          writerUid: uid,
          id: oldData.id,
          description: description,
          title: title,
          assets: assets,
        );
      }
      dataList.remove(oldData);
      dataList.add(newData);
      ExerciseModel model = ExerciseModel(
        id: exercise.id,
        image: exercise.image,
        order: exercise.order,
        title: exercise.title,
        data: dataList,
      );
      await FirebaseFirestore.instance
          .collection('exercises')
          .doc('data')
          .collection('data')
          .doc(exercise.id)
          .update(
            model.toJson(),
          );

      list.remove(exercise);
      list.add(model);
      return right(list);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, List<ExerciseModel>>> removeExercise({
    required ExerciseModel exercise,
    required DataModel oldData,
  }) async {
    try {
      List<DataModel> dataList = exercise.data ?? [];
      dataList.remove(oldData);
      ExerciseModel model = ExerciseModel(
        id: exercise.id,
        image: exercise.image,
        order: exercise.order,
        title: exercise.title,
        data: dataList,
      );
      await FirebaseFirestore.instance
          .collection('exercises')
          .doc('data')
          .collection('data')
          .doc(exercise.id)
          .update(
            model.toJson(),
          );
      List<ExerciseModel> exercises =
          await exerciseRemoteDataSource.getExercises();
      return right(exercises);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, List<ExerciseModel>>> moveExercise({
    required List<ExerciseModel> list,
    required ExerciseModel oldCategory,
    required ExerciseModel newCategory,
    required DataModel oldData,
  }) async {
    try {
      List<DataModel> oldDataList = oldCategory.data ?? [];
      oldDataList.remove(oldData);
      ExerciseModel oldModel = ExerciseModel(
        id: oldCategory.id,
        image: oldCategory.image,
        order: oldCategory.order,
        title: oldCategory.title,
        data: oldDataList,
      );
      await FirebaseFirestore.instance
          .collection('exercises')
          .doc('data')
          .collection('data')
          .doc(oldCategory.id)
          .update(
            oldModel.toJson(),
          );

      List<DataModel> newDataList = newCategory.data ?? [];
      newDataList.add(oldData);
      ExerciseModel newModel = ExerciseModel(
        id: newCategory.id,
        image: newCategory.image,
        order: newCategory.order,
        title: newCategory.title,
        data: newDataList,
      );
      await FirebaseFirestore.instance
          .collection('exercises')
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
