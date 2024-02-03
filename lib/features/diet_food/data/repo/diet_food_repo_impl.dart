import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:tamrini/core/api/dio_helper.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/models/notification_model/notification_model.dart';
import 'package:tamrini/core/services/upload_image.dart';
import 'package:tamrini/features/diet_food/data/data_sources/remote_data_source/diet_food_remote_data_source.dart';
import 'package:tamrini/features/diet_food/data/models/diet_food_model.dart/diet_food_model.dart';
import 'package:tamrini/features/diet_food/domain/repo/diet_food_repo.dart';

class DietFoodRepoImpl extends DietFoodRepo {
  final DietFoodRemoteDataSource dietFoodRemoteDataSource;
  final DioHelper dioHelper;

  DietFoodRepoImpl(this.dietFoodRemoteDataSource, this.dioHelper);
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
        isRefused: false,
        isPending: false,
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
          isRefused: false,
          id: '',
          writerUid: oldModel.writerUid,
          isPending: oldModel.isPending,
        );
      } else {
        List<String> images = await upload(paths);
        await deleteOldImages(newImages: [], oldImages: oldModel.assets);
        model = DietFoodModel(
          assets: images,
          description: description,
          title: name,
          date: oldModel.date,
          isRefused: oldModel.isRefused,
          id: '',
          writerUid: oldModel.writerUid,
          isPending: oldModel.isPending,
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

  @override
  Future<Either<String, List<DietFoodModel>>> banFood({
    required String id,
    required String writerUid,
    required bool isPending,
  }) async {
    try {
      await FirebaseFirestore.instance
          .collection('dietFood')
          .doc('data')
          .collection('data')
          .doc(id)
          .update(
        {
          "isRefused": isPending,
          "isPending": isPending,
        },
      );
      sendNotification(writerUid, id, isPending);
      List<DietFoodModel> list = await dietFoodRemoteDataSource.get();
      return right(list);
    } catch (e) {
      return left(e.toString());
    }
  }

  Future<void> sendNotification(
    String writerId,
    String foodId,
    bool isRefused,
  ) async {
    var data = await FirebaseFirestore.instance
        .collection('users')
        .doc(writerId)
        .get();
    String token = data['token'] ?? '';
    if (token != '') {
      dioHelper.sendNotification(
        token: token,
        title: 'مقالاتك',
        body: isRefused == false
            ? 'تم رفع التقييد عن المقال الخاص بك'
            : 'تم تقييد المقال الخاص بك',
        data: {
          "type": "notification",
          "subType": 'diet_food',
          "uid": foodId,
        },
      );
    }

    NotificationModel model = NotificationModel(
      isReaden: false,
      subType: 'diet_food',
      senderUid: adminUid,
      title: isRefused == true ? 'ban_food' : 'no_ban_food',
      body: '',
      type: 'notification',
      uid: foodId,
      time: Timestamp.now(),
    );
    await FirebaseFirestore.instance
        .collection('notification')
        .doc(writerId)
        .collection('data')
        .add(
          model.toJson(),
        );
  }
}
