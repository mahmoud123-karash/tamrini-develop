import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:tamrini/core/services/upload_image.dart';
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
