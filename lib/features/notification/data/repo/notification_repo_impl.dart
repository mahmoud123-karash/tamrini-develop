import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
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

      return right(list);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, List<NotificationModel>>> updateNotification({
    required List<NotificationModel> list,
    required NotificationModel model,
  }) async {
    try {
      String uid = CacheHelper.getData(key: 'uid');
      await FirebaseFirestore.instance
          .collection('notification')
          .doc(uid)
          .collection('data')
          .doc(model.notificationUid)
          .update(
        {
          "isReaden": true,
        },
      );
      model.isReaden = true;
      return right(list);
    } catch (e) {
      return left(e.toString());
    }
  }
}
