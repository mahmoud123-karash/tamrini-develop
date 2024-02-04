// ignore_for_file: file_names

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:tamrini/core/services/upload_image.dart';
import 'package:tamrini/features/food/data/data_sources/remote_data_source/supplement_remote_data_source.dart';
import 'package:tamrini/features/food/data/models/supplement_model/supplement_model.dart';
import 'package:tamrini/features/food/domain/repo/food_repo.dart';

class FoodRepoImpl extends FoodRepo {
  final SupplementRemoteDataSource supplementRemoteDataSource;

  FoodRepoImpl(this.supplementRemoteDataSource);
  @override
  Future<Either<String, List<SupplementModel>>> get() async {
    try {
      List<SupplementModel> list = await supplementRemoteDataSource.get();
      return right(list);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, List<SupplementModel>>> addCategory({
    required String imagePath,
    required String title,
  }) async {
    try {
      List<String> images = await uploadImages(imagePath);
      SupplementModel model = SupplementModel(
        image: images.isEmpty ? '' : images.first,
        data: [],
        title: title,
      );
      await FirebaseFirestore.instance
          .collection('supplements')
          .doc('data')
          .collection('data')
          .add(
            model.toJson(),
          );
      List<SupplementModel> list = await supplementRemoteDataSource.get();
      return right(list);
    } catch (e) {
      return left(e.toString());
    }
  }

  Future<List<String>> uploadImages(String imagePath) async {
    List files = [];
    files.add(File(imagePath));
    List<String> images = await uploadFiles(files: files);
    return images;
  }

  @override
  Future<Either<String, List<SupplementModel>>> editCategory({
    required String imagePath,
    required String title,
    required SupplementModel oldModel,
  }) async {
    try {
      late SupplementModel model;
      if (imagePath == '') {
        model = SupplementModel(
          image: oldModel.image,
          data: oldModel.data,
          title: title,
        );
      } else {
        if (oldModel.image != '') {
          List<String> oldImages = [];
          oldImages.add(oldModel.image);
          await deleteOldImages(newImages: [], oldImages: oldImages);
        }
        List<String> images = await uploadImages(imagePath);
        model = SupplementModel(
          image: images.isEmpty ? '' : images.first,
          data: oldModel.data,
          title: title,
        );
      }

      await FirebaseFirestore.instance
          .collection('supplements')
          .doc('data')
          .collection('data')
          .doc(oldModel.id)
          .update(
            model.toJson(),
          );
      List<SupplementModel> list = await supplementRemoteDataSource.get();
      return right(list);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, List<SupplementModel>>> removeCategory({
    required SupplementModel oldModel,
  }) async {
    try {
      if (oldModel.image != '') {
        List<String> oldImages = [];
        oldImages.add(oldModel.image);
        await deleteOldImages(newImages: [], oldImages: oldImages);
      }
      await FirebaseFirestore.instance
          .collection('supplements')
          .doc('data')
          .collection('data')
          .doc(oldModel.id)
          .delete();
      List<SupplementModel> list = await supplementRemoteDataSource.get();
      return right(list);
    } catch (e) {
      return left(e.toString());
    }
  }
}
