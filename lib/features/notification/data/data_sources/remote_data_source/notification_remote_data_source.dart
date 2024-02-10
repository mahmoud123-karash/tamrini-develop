import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/models/user_model/user_model.dart';
import 'package:tamrini/core/services/location.dart';
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
      UserModel? user = await getUser(element);
      NotificationModel model =
          NotificationModel.fromJson(element.data(), element.id, user);
      list.add(model);
    }
    return list;
  }

  Future<UserModel> getUser(
    QueryDocumentSnapshot<Map<String, dynamic>> element,
  ) async {
    String senderUid = element.data()['senderUid'] ?? '';

    var result = await FirebaseFirestore.instance
        .collection('users')
        .doc(senderUid)
        .get();
    GeoPoint defultLocation = const GeoPoint(33.312805, 44.361488);
    GeoPoint location = result.data() == null
        ? defultLocation
        : result.data()!['location'] ?? defultLocation;
    String address = await getAddress(location: location);
    UserModel user = UserModel.fromMap(result.data()!, result.id, address);
    return user;
  }
}
