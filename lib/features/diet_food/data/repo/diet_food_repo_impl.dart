import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/services/upload_image.dart';
import 'package:tamrini/features/diet_food/data/data_sources/remote_data_source/diet_food_remote_data_source.dart';
import 'package:tamrini/features/diet_food/data/models/diet_food_model.dart/diet_food_model.dart';
import 'package:tamrini/features/diet_food/domain/repo/diet_food_repo.dart';

class DietFoodRepoImpl extends DietFoodRepo {
  final DietFoodRemoteDataSource dietFoodRemoteDataSource;

  DietFoodRepoImpl(this.dietFoodRemoteDataSource);
  @override
  Future<Either<String, List<DietFoodModel>>> get() async {
    try {
      List<DietFoodModel> list = await dietFoodRemoteDataSource.get();
      return right(list);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, List<DietFoodModel>>> addMeal({
    required String name,
    required String description,
    required List<String> paths,
  }) async {
    String uid = CacheHelper.getData(key: 'uid');
    try {
      List<String> assets = await upload(paths);
      DietFoodModel model = DietFoodModel(
        assets: assets,
        description: description,
        title: name,
        date: Timestamp.now(),
        id: '',
        writerUid: uid,
      );
      await FirebaseFirestore.instance
          .collection('dietFood')
          .doc('data')
          .collection('data')
          .add(
            model.toJson(),
          );

      List<DietFoodModel> list = await dietFoodRemoteDataSource.get();
      return right(list);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, List<DietFoodModel>>> editMeal({
    required String name,
    required String description,
    required List<String> paths,
    required DietFoodModel oldModel,
  }) async {
    try {
      late DietFoodModel model;
      if (paths.isEmpty) {
        model = DietFoodModel(
          assets: oldModel.assets,
          description: description,
          title: name,
          date: oldModel.date,
          id: '',
          writerUid: oldModel.writerUid,
        );
      } else {
        List<String> images = await upload(paths);
        List<String> oldImages = [];
        oldImages.addAll(paths);
        await deleteOldImages(newImages: [], oldImages: oldImages);
        model = DietFoodModel(
          assets: images,
          description: description,
          title: name,
          date: oldModel.date,
          id: '',
          writerUid: oldModel.writerUid,
        );
      }
      await FirebaseFirestore.instance
          .collection('dietFood')
          .doc('data')
          .collection('data')
          .doc(oldModel.id)
          .update(
            model.toJson(),
          );
      List<DietFoodModel> list = await dietFoodRemoteDataSource.get();
      return right(list);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, List<DietFoodModel>>> removeMeal({
    required String id,
    required List<String> assets,
  }) async {
    try {
      await deleteOldImages(newImages: [], oldImages: assets);
      await FirebaseFirestore.instance
          .collection('dietFood')
          .doc('data')
          .collection('data')
          .doc(id)
          .delete();
      List<DietFoodModel> list = await dietFoodRemoteDataSource.get();
      return right(list);
    } catch (e) {
      return left(e.toString());
    }
  }

  Future<List<String>> upload(List<String> paths) async {
    List files = [];
    for (var element in paths) {
      files.add(File(element));
    }
    List<String> assets = await uploadFiles(files: files);
    return assets;
  }
}
