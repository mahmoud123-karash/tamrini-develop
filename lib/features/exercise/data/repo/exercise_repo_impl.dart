import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
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
      List files = [];
      files.add(File(imagePath));
      List<String> images = await uploadFiles(files: files);
      List<DataModel> dataList = exercise.data ?? [];
      var id = const Uuid().v4();
      List<String> assets = [];
      assets.addAll([youtubUrl, ...images]);
      DataModel data = DataModel(
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
      List<DataModel> dataList = exercise.data ?? [];
      late DataModel newData;
      if (imagePath == '') {
        List<String> assets = [];
        assets.add(youtubUrl);
        if (checkImageformat(oldData.assets ?? []) != '') {
          assets.add(checkImageformat(oldData.assets ?? []));
        }
        newData = DataModel(
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
        assets.addAll([youtubUrl, ...images]);
        newData = DataModel(
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
}
