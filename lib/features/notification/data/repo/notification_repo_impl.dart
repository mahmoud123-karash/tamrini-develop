import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:tamrini/core/cache/save_data.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/features/notification/data/data_sources/remote_data_source/notification_remote_data_source.dart';
import 'package:tamrini/features/notification/data/models/notification_model/notification_model.dart';
import 'package:tamrini/features/notification/domain/repo/notification_repo.dart';

class NotificationRepoImpl extends NotificationRepo {
  final NotificationRemoteDataSource notificationRemoteDataSource;

  NotificationRepoImpl(this.notificationRemoteDataSource);
  @override
  Future<Either<String, List<NotificationModel>>> get() async {
    try {
      List<NotificationModel> list = await notificationRemoteDataSource.get();
      List<NotificationModel> unReadList =
          list.where((element) => element.isReaden == false).toList();
      List<NotificationModel> notificationsList = list
          .where((element) => element.type == 'notification')
          .where((element) => element.isReaden == false)
          .toList();
      List<NotificationModel> messagesList = list
          .where((element) => element.type == 'message')
          .where((element) => element.isReaden == false)
          .toList();
      List<NotificationModel> systemList = list
          .where((element) => element.type == 'system')
          .where((element) => element.isReaden == false)
          .toList();
      saveUnReadList(unReadList.length);
      saveNotificationList(notificationsList.length);
      saveMessagesList(messagesList.length);
      saveSystemList(systemList.length);
      return right(list);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, List<NotificationModel>>> updateNotification({
    required List<NotificationModel> list,
    required String lable,
  }) async {
    try {
      List<NotificationModel> finalList = list
          .where((element) => element.type == lable)
          .where((element) => element.isReaden == false)
          .toList();
      for (var element in finalList) {
        String uid = CacheHelper.getData(key: 'uid');
        await FirebaseFirestore.instance
            .collection('notification')
            .doc(uid)
            .collection('data')
            .doc(element.notificationUid)
            .update(
          {
            "isReaden": true,
          },
        );
        element.isReaden = true;
      }
      return right(list);
    } catch (e) {
      return left(e.toString());
    }
  }
}
