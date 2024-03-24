import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:tamrini/core/api/dio_helper.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/models/notification_model/notification_model.dart';

abstract class UseCase {
  Future<Either<String, String>> ban({
    required String uid,
    required bool isBanned,
  });
}

class BanUserUseCase extends UseCase {
  final DioHelper dioHelper;
  var fireStore = FirebaseFirestore.instance.collection('users');

  BanUserUseCase(this.dioHelper);
  @override
  Future<Either<String, String>> ban({
    required String uid,
    required bool isBanned,
  }) async {
    try {
      fireStore.doc(uid).update({
        "isBanned": isBanned,
      });
      sendNotification(isBanned: isBanned, userId: uid);
      return right('');
    } catch (e) {
      return left(e.toString());
    }
  }

  Future<void> sendNotification({
    required bool isBanned,
    required String userId,
  }) async {
    NotificationModel notification = NotificationModel(
      isReaden: false,
      subType: 'ban_user',
      senderUid: adminUid,
      title: isBanned == true ? 'ban_user' : 'no_ban_user',
      body: '',
      type: 'notification',
      uid: userId,
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
        title: 'مرحبا بك',
        body: isBanned == false
            ? 'عزيزي المستخدم تم رفع الحظر من قبل المدير'
            : 'عزيزي المستخدم، نأسف لإبلاغك بأن حسابك قد تم حظره من قبل المدير. إذا كان لديك أي أسئلة أو استفسارات، يرجى التواصل مع فريق الدعم الخاص بنا للحصول على المساعدة اللازمة',
        data: {
          "type": "notification",
          "subType": "ban_user",
          "uid": userId,
        },
      );
    }
  }
}
