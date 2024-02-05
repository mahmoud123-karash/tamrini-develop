import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:tamrini/core/services/upload_image.dart';
import 'package:tamrini/features/home_exercise/data/data_sources/remote_data_source/home_exercise_remote_data_source.dart';
import 'package:tamrini/features/home_exercise/data/models/home_exercise/home_exercise_model.dart';

import 'package:tamrini/features/home_exercise/domain/repo/home_exercise_repo.dart';

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
}
