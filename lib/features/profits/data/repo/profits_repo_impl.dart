import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:tamrini/core/api/dio_helper.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/models/notification_model/notification_model.dart';
import 'package:tamrini/features/profits/data/data_sources/remote_data_source/profits_remote_data_source.dart';
import 'package:tamrini/features/profits/data/models/profits_model/profits_model.dart';
import 'package:tamrini/features/profits/domain/repo/profits_repo.dart';
import 'package:uuid/uuid.dart';

class ProfitsRepoImpl extends ProfitsRepo {
  final ProfitsRemoteDataSource profitsRemoteDataSource;
  final DioHelper dioHelper;
  ProfitsRepoImpl(this.profitsRemoteDataSource, this.dioHelper);
  @override
  Future<Either<String, List<ProfitsModel>>> get() async {
    try {
      List<ProfitsModel> list = await profitsRemoteDataSource.get();
      return right(list);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, List<ProfitsModel>>> accept({
    required ProfitsModel model,
  }) async {
    try {
      await FirebaseFirestore.instance
          .collection('profits')
          .doc(model.requestuid)
          .update({
        "status": "done",
      });
      sendAcceptNotification(reciverId: model.userId, userRole: model.userType);
      await updateAData(
        userType: model.userType,
        id: model.uid,
        amount: model.amount,
      );
      List<ProfitsModel> list = await profitsRemoteDataSource.get();
      return right(list);
    } catch (e) {
      return left(e.toString());
    }
  }

  Future<void> updateAData({
    required String userType,
    required String id,
    required num amount,
  }) async {
    if (userType == 'tariner') {
      var fireStore = FirebaseFirestore.instance
          .collection('trainers')
          .doc('data')
          .collection('data')
          .doc(id);
      var result = await fireStore.get();
      num allProfits = result.data()!['profits'] ?? 0;
      await fireStore.update({
        "isRequestProfits": false,
        "profits": allProfits - amount,
      });
    }
    if (userType == 'gym owner') {
      var fireStore = FirebaseFirestore.instance
          .collection('gyms')
          .doc('data')
          .collection('data')
          .doc(id);
      var result = await fireStore.get();
      num allProfits = result.data()!['profits'] ?? 0;
      await fireStore.update({
        "isRequestProfits": false,
        "profits": allProfits - amount,
      });
    }
    if (userType == 'store owner') {
      var fireStore = FirebaseFirestore.instance.collection('stores').doc(id);
      var result = await fireStore.get();
      num allProfits = result.data()!['profits'] ?? 0;
      await fireStore.update({
        "isRequestProfits": false,
        "profits": allProfits - amount,
      });
    }
  }

  Future<void> sendAcceptNotification({
    required String reciverId,
    required String userRole,
  }) async {
    var data = await FirebaseFirestore.instance
        .collection('users')
        .doc(reciverId)
        .get();
    String token = data['token'] ?? '';
    if (token != '') {
      dioHelper.sendNotification(
        token: token,
        title: 'تم قبول طلب سحب الأرباح',
        body: 'تم ارسال الأرباح الى حسابك ',
        data: {
          "type": "notification",
          "subType": 'accept_profits',
          "user_role": userRole,
          "uid": reciverId,
        },
      );
    }

    NotificationModel model = NotificationModel(
      isReaden: false,
      subType: 'accept_profits',
      senderUid: adminUid,
      title: 'accept_profits',
      body: '',
      type: 'notification',
      uid: reciverId,
      time: Timestamp.now(),
    );
    await FirebaseFirestore.instance
        .collection('notification')
        .doc(reciverId)
        .collection('data')
        .add(
          model.toJson(),
        );
  }

  @override
  Future<Either<String, List<ProfitsModel>>> removeRequest(
      {required String id}) async {
    try {
      await FirebaseFirestore.instance.collection('profits').doc(id).delete();
      List<ProfitsModel> list = await profitsRemoteDataSource.get();
      return right(list);
    } catch (e) {
      return left(e.toString());
    }
  }

////////////////////////////////////////////////////////////////////////////////

  @override
  Future<Either<String, List<ProfitsModel>>> getMyRequests({
    required String uid,
  }) async {
    try {
      List<ProfitsModel> list =
          await profitsRemoteDataSource.getMyRequest(uid: uid);
      return right(list);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, List<ProfitsModel>>> request({
    required num amount,
    required String id,
    required String cashNumber,
  }) async {
    try {
      String userType = CacheHelper.getData(key: 'usertype');
      String uid = CacheHelper.getData(key: 'uid');
      var uuid = const Uuid().v4();
      ProfitsModel model = ProfitsModel(
        userId: uid,
        uid: id,
        cashNumber: cashNumber,
        status: 'wating',
        userType: userType,
        requestuid: uuid,
        amount: amount,
        requestedAt: Timestamp.now(),
      );
      await FirebaseFirestore.instance.collection('profits').doc(uuid).set(
            model.toJson(),
          );
      await updateData(userType: userType, id: id, isRequestProfits: true);
      sendRequestNotification(uid);
      List<ProfitsModel> list = await profitsRemoteDataSource.getMyRequest(
        uid: id,
      );
      return right(list);
    } catch (e) {
      return left(e.toString());
    }
  }

  Future<void> updateData({
    required String userType,
    required String id,
    required bool isRequestProfits,
  }) async {
    if (userType == 'tariner') {
      await FirebaseFirestore.instance
          .collection('trainers')
          .doc('data')
          .collection('data')
          .doc(id)
          .update({
        "isRequestProfits": isRequestProfits,
      });
    }
    if (userType == 'gym owner') {
      await FirebaseFirestore.instance
          .collection('gyms')
          .doc('data')
          .collection('data')
          .doc(id)
          .update({
        "isRequestProfits": isRequestProfits,
      });
    }
    if (userType == 'store owner') {
      FirebaseFirestore.instance.collection('stores').doc(id).update({
        "isRequestProfits": isRequestProfits,
      });
    }
  }

  Future<void> sendRequestNotification(
    String senderId,
  ) async {
    var data = await FirebaseFirestore.instance
        .collection('users')
        .doc(adminUid)
        .get();
    String token = data['token'] ?? '';
    if (token != '') {
      dioHelper.sendNotification(
        token: token,
        title: 'سحب رصيد',
        body: 'طلب سحب رصيد جديد',
        data: {
          "type": "notification",
          "subType": 'request_profits',
        },
      );
    }

    NotificationModel model = NotificationModel(
      isReaden: false,
      subType: 'request_profits',
      senderUid: senderId,
      title: 'request_profits',
      body: '',
      type: 'notification',
      uid: '',
      time: Timestamp.now(),
    );
    await FirebaseFirestore.instance
        .collection('notification')
        .doc(adminUid)
        .collection('data')
        .add(
          model.toJson(),
        );
  }
}
