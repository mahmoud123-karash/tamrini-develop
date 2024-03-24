import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:tamrini/core/cache/save_data.dart';
import 'package:tamrini/core/cache/shared_preference.dart';

class NavBarRepo {
  void update() async {
    String uid = CacheHelper.getData(key: 'uid');
    String cachedToken = CacheHelper.getData(key: 'deviceToken') ?? '';
    if (cachedToken == '') {
      FirebaseMessaging messaging = FirebaseMessaging.instance;
      String token = await messaging.getToken() ?? '';
      saveDeviceToken(token);
      await FirebaseFirestore.instance.collection('users').doc(uid).update(
        {
          "uid": uid,
          "token": token,
        },
      );
    }
  }
}
