import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:tamrini/core/api/dio_helper.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/models/subscription_model/subscription_model.dart';
import 'package:tamrini/core/services/upload_image.dart';
import 'package:tamrini/core/models/notification_model/notification_model.dart';
import 'package:tamrini/features/gym/data/data_sources/remote_data_source/gym_remote_data_source.dart';
import 'package:tamrini/features/gym/data/models/gym_model/gym_model.dart';
import 'package:tamrini/features/gym/data/models/subscriber_model/subscriber_model.dart';
import 'package:tamrini/features/gym/domain/repo/gym_repo.dart';
import 'package:uuid/uuid.dart';

class GymRepoImpl extends GymRepo {
  final GymRemoteDataSource gymRemoteDataSource;
  final DioHelper dioHelper;

  GymRepoImpl(this.gymRemoteDataSource, this.dioHelper);

  @override
  Future<Either<String, List<GymModel>>> getGyms({
    required bool update,
  }) async {
    return await gymRemoteDataSource.getGyms(update: update);
  }

  @override
  Future<Either<String, List<GymModel>>> addGym({
    required List<String> paths,
    required String name,
    required String description,
    required int price,
    required double lat,
    required double long,
  }) async {
    try {
      String uid = CacheHelper.getData(key: 'uid');
      List<String> assets = await uploadGymImages(paths);
      GymModel model = GymModel(
        assets: assets,
        name: name,
        location: GeoPoint(lat, long),
        price: price,
        subcribersCount: 0,
        id: '',
        description: description,
        distance: 0,
        ownerUid: uid,
        isBanned: false,
      );
      await FirebaseFirestore.instance
          .collection('gyms')
          .doc('data')
          .collection('data')
          .add(
            model.toJson(),
          );
      return await gymRemoteDataSource.getGyms(update: false);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, List<GymModel>>> editGym({
    required List<String> paths,
    required String name,
    required String description,
    required int price,
    required double lat,
    required double long,
    required GymModel oldModel,
    required List<String> images,
  }) async {
    try {
      String uid = CacheHelper.getData(key: 'uid');
      late GymModel model;
      if (paths.isEmpty) {
        model = GymModel(
          assets: oldModel.assets,
          name: name,
          location: GeoPoint(lat, long),
          price: price,
          id: '',
          description: description,
          subcribersCount: oldModel.subcribersCount,
          distance: 0,
          ownerUid: uid,
          isBanned: false,
        );
      } else {
        List<String> assets = await uploadGymImages(paths);
        List<String> newImages = [];
        newImages.addAll(images);
        newImages.addAll(assets);
        await deleteOldImages(newImages: newImages, oldImages: oldModel.assets);
        model = GymModel(
          assets: newImages,
          name: name,
          location: GeoPoint(lat, long),
          subcribersCount: oldModel.subcribersCount,
          price: price,
          id: '',
          description: description,
          distance: 0,
          ownerUid: uid,
          isBanned: false,
        );
      }

      await FirebaseFirestore.instance
          .collection('gyms')
          .doc('data')
          .collection('data')
          .doc(oldModel.id)
          .update(
            model.toJson(),
          );
      return await gymRemoteDataSource.getGyms(update: false);
    } catch (e) {
      return left(e.toString());
    }
  }

  Future<List<String>> uploadGymImages(List<String> paths) async {
    List files = [];
    for (var element in paths) {
      files.add(File(element));
    }
    List<String> assets = await uploadFiles(files: files);
    return assets;
  }

  @override
  Future<Either<String, List<GymModel>>> banGym({
    required String gymId,
    required String ownerId,
    required bool isBannd,
  }) async {
    try {
      await sendNotification(ownerId, gymId, isBannd);
      await FirebaseFirestore.instance
          .collection('gyms')
          .doc('data')
          .collection('data')
          .doc(gymId)
          .update({
        'isBanned': isBannd,
      });
      return await gymRemoteDataSource.getGyms(update: false);
    } catch (e) {
      return left(e.toString());
    }
  }

  Future<void> sendNotification(
      String ownerId, String gymId, bool isBanned) async {
    var data =
        await FirebaseFirestore.instance.collection('users').doc(ownerId).get();
    String token = data['token'] ?? '';
    if (token != '') {
      dioHelper.sendNotification(
        token: token,
        title: 'تقييد الصالة الرياضية',
        body: !isBanned
            ? 'تم رفع التقييد عن الصالة الرياضية الخاصة بك'
            : 'تم تقييد الصالة الرياضية الخاصة بك',
        data: {
          "type": "notification",
          "subType": 'ban_gym',
        },
      );
    }

    NotificationModel model = NotificationModel(
      isReaden: false,
      subType: 'ban_gym',
      senderUid: adminUid,
      title: isBanned ? 'ban_gym' : 'no_ban_gym',
      body: '',
      type: 'notification',
      uid: gymId,
      time: Timestamp.now(),
    );
    await FirebaseFirestore.instance
        .collection('notification')
        .doc(ownerId)
        .collection('data')
        .add(
          model.toJson(),
        );
  }

  @override
  Future<Either<String, List<SubscriberModel>>> getSubscribers({
    required String gymId,
  }) async {
    try {
      List<SubscriberModel> list = await gymRemoteDataSource.get(gymId: gymId);
      return right(list);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, List<SubscriberModel>>> subUser({
    required String gymId,
    required int count,
    required num price,
  }) async {
    try {
      String uid = CacheHelper.getData(key: 'uid');
      Timestamp endDate = Timestamp.fromDate(
        Timestamp.now().toDate().add(
              const Duration(days: 30),
            ),
      );
      var uuid = const Uuid().v4();
      SubscriberModel model = SubscriberModel(
        uid: uuid,
        userId: uid,
        subDate: Timestamp.now(),
        endDate: endDate,
        paymentMethod: 'Zain Cash',
        price: price,
      );
      await FirebaseFirestore.instance
          .collection('gyms')
          .doc('data')
          .collection('data')
          .doc(gymId)
          .collection('subscribers')
          .doc(uuid)
          .set(
            model.toJson(),
          );

      await updateGymSubCount(gymId: gymId, count: count);
      await addSubUser(uuid, endDate, gymId, price, uid);
      List<SubscriberModel> list = await gymRemoteDataSource.get(gymId: gymId);
      return right(list);
    } catch (e) {
      return left(e.toString());
    }
  }

  Future<void> addSubUser(String uuid, Timestamp endDate, String gymId,
      num price, String uid) async {
    SubscriptionModel sModel = SubscriptionModel(
      uid: uuid,
      subDate: Timestamp.now(),
      endDate: endDate,
      gymId: gymId,
      paymentMethod: 'Zain Cash',
      price: price,
    );
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('Subscriptions')
        .doc(uuid)
        .set(
          sModel.toJson(),
        );
  }

  Future<void> updateGymSubCount(
      {required String gymId, required int count}) async {
    await FirebaseFirestore.instance
        .collection('gyms')
        .doc('data')
        .collection('data')
        .doc(gymId)
        .update(
      {
        "subcribersCount": count,
      },
    );
  }

  @override
  Future<Either<String, List<SubscriberModel>>> renewSub({
    required String gymId,
    required String subId,
    required num price,
  }) async {
    try {
      String uid = CacheHelper.getData(key: 'uid');
      Timestamp endDate = Timestamp.fromDate(
        Timestamp.now().toDate().add(
              const Duration(days: 30),
            ),
      );
      SubscriberModel model = SubscriberModel(
        uid: subId,
        userId: uid,
        subDate: Timestamp.now(),
        endDate: endDate,
        paymentMethod: 'Zain Cash',
        price: price,
      );
      await FirebaseFirestore.instance
          .collection('gyms')
          .doc('data')
          .collection('data')
          .doc(gymId)
          .collection('subscribers')
          .doc(subId)
          .set(
            model.toJson(),
          );

      await addSubUser(subId, endDate, gymId, price, uid);
      List<SubscriberModel> list = await gymRemoteDataSource.get(gymId: gymId);
      return right(list);
    } catch (e) {
      return left(e.toString());
    }
  }
}
