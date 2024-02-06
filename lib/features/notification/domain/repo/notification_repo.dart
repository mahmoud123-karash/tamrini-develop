import 'package:dartz/dartz.dart';
import 'package:tamrini/features/notification/data/models/notification_model/notification_model.dart';

abstract class NotificationRepo {
  Future<Either<String, List<NotificationModel>>> get();
  Future<Either<String, List<NotificationModel>>> updateNotification({
    required List<NotificationModel> list,
        required NotificationModel model,

  });
}
