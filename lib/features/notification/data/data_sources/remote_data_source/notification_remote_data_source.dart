import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/models/user_model/user_model.dart';
import 'package:tamrini/core/services/services.dart';
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
      UserModel? user = await getUser(element.data()['senderUid'] ?? adminUid);
      NotificationModel model =
          NotificationModel.fromJson(element.data(), element.id, user);
      list.add(model);
    }
    return list;
  }
}
