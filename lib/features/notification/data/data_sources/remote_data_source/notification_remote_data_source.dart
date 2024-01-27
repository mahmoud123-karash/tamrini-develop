import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/features/notification/data/models/notification_model/notification_model.dart';

abstract class NotificationRemoteDataSource {
  Future<List<NotificationModel>> get();
}

class NotificationRemoteDataSourceImpl extends NotificationRemoteDataSource {
  @override
  Future<List<NotificationModel>> get() async {
    List<NotificationModel> list = [];
    String uid = CacheHelper.getData(key: 'uid');
    var result = await FirebaseFirestore.instance
        .collection('notification')
        .doc(uid)
        .collection('data')
        .orderBy('time', descending: true)
        .get();
    for (var element in result.docs) {
      NotificationModel model =
          NotificationModel.fromJson(element.data(), element.id);
      list.add(model);
    }
    return list;
  }
}
