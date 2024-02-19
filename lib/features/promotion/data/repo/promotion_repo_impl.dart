import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:tamrini/core/api/dio_helper.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/models/notification_model/notification_model.dart';
import 'package:tamrini/features/promotion/data/data_source/remote_data_source/promotion_remote_data_source.dart';

import 'package:tamrini/features/promotion/data/models/promotion_model/promotion_model.dart';
import 'package:tamrini/features/trainer/data/models/trainer_model/trainer_model.dart';
import 'package:uuid/uuid.dart';

import '../../domain/repo/promotion_repo.dart';

class PromotionRepoImpl extends PromotionRepo {
  final PromotionRemoteDataSource promotionRemoteDataSource;
  final DioHelper dioHelper;

  PromotionRepoImpl(this.promotionRemoteDataSource, this.dioHelper);
  @override
  Future<Either<String, List<PromotionModel>>> getPromotion() async {
    try {
      List<PromotionModel> list = await promotionRemoteDataSource.get();
      return right(list);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, List<PromotionModel>>> requestpromotion({
    required String promotionType,
  }) async {
    try {
      var uuid = const Uuid().v4();
      String uid = CacheHelper.getData(key: 'uid');
      PromotionModel model = PromotionModel(
        uid: uuid,
        userId: uid,
        promotionType: promotionType,
        requestTime: Timestamp.now(),
      );
      await FirebaseFirestore.instance
          .collection('users')
          .doc(adminUid)
          .collection('promotions')
          .doc(uuid)
          .set(
            model.toJson(),
          );
      await sendNotification(promotionId: uuid, promotionType: promotionType);
      List<PromotionModel> list = await promotionRemoteDataSource.get();
      return right(list);
    } catch (e) {
      return left(e.toString());
    }
  }

  Future<void> sendNotification({
    required String promotionId,
    required String promotionType,
  }) async {
    String uid = CacheHelper.getData(key: 'uid');
    NotificationModel notification = NotificationModel(
      isReaden: false,
      subType: 'promotion',
      senderUid: uid,
      title: 'promotion',
      body: promotionType,
      type: 'notification',
      uid: promotionId,
      time: Timestamp.now(),
    );
    await FirebaseFirestore.instance
        .collection('notification')
        .doc(adminUid)
        .collection('data')
        .add(
          notification.toJson(),
        );
    var data = await FirebaseFirestore.instance
        .collection('users')
        .doc(adminUid)
        .get();
    String token = data['token'] ?? '';
    if (token != '') {
      dioHelper.sendNotification(
        token: token,
        title: 'طلب ترقية جديد',
        body: promotionType,
        data: {
          "type": "notification",
          "subType": "promotion",
          "uid": promotionId,
        },
      );
    }
  }

  @override
  Future<Either<String, List<PromotionModel>>> acceptRefuseRequestpromotion({
    required PromotionModel model,
    required bool isAccept,
  }) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(adminUid)
          .collection('promotions')
          .doc(model.uid)
          .delete();
      if (isAccept == true) {
        await updateUserRole(model);
        await sendUserNotification(
          promotionType: model.promotionType,
          userId: model.userId,
        );
        if (model.promotionType == 'trainer') {
          await addNewtrainer(model);
        }
      }
      List<PromotionModel> list = await promotionRemoteDataSource.get();
      return right(list);
    } catch (e) {
      return left(e.toString());
    }
  }

  Future<void> addNewtrainer(PromotionModel model) async {
    TrainerModel trainer = TrainerModel(
      isBanned: false,
      description: '',
      questionsTrainees: [],
      isRequestProfits: false,
      uid: model.userId,
      price: 0,
      profits: 0,
      traineesCount: 0,
      gallery: [],
      fromH: '',
      toH: '',
    );
    await FirebaseFirestore.instance
        .collection('trainers')
        .doc('data')
        .collection('data')
        .doc(model.userId)
        .set(
          trainer.toJson(),
        );
  }

  Future<void> updateUserRole(PromotionModel model) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(model.userId)
        .update(
      {
        "role": model.promotionType,
      },
    );
  }

  Future<void> sendUserNotification({
    required String promotionType,
    required String userId,
  }) async {
    NotificationModel notification = NotificationModel(
      isReaden: false,
      subType: 'promotion_accept',
      senderUid: adminUid,
      title: 'promotion_accept',
      body: promotionType,
      type: 'notification',
      uid: '',
      time: Timestamp.now(),
    );
    await FirebaseFirestore.instance
        .collection('notification')
        .doc(userId)
        .collection('data')
        .add(
          notification.toJson(),
        );
    var data =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    String token = data['token'] ?? '';
    if (token != '') {
      dioHelper.sendNotification(
        token: token,
        title: 'تم ترقية حسابك إلي',
        body: promotionType,
        data: {
          "type": "notification",
          "subType": "promotion_accept",
          "promotionType": promotionType,
        },
      );
    }
  }
}
