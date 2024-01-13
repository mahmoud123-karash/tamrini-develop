import 'dart:convert';

import 'package:dio/dio.dart';

class DioHelper {
  final Dio dio;
  var url = Uri.parse('https://fcm.googleapis.com/fcm/send');

  var headersList = {
    'Content-Type': 'application/json',
    'Authorization':
        'key=AAAAfbzjySQ:APA91bHNB8Mzb3OcYlRUbYbqBZ2WDj_DPyuRXYBGjF09aIYhvO2myUidGcpGtIKElRgPha-bFf4ooN14OO0DO6kab2nIfDNlhIhXhnLbZ5Hn3cgTDA18t2x-X_qzE_P2p5dytEdrsLru'
  };

  DioHelper(this.dio);

  void sendNotification({
    required String token,
    required String title,
    required String body,
    Map<String, dynamic>? data,
  }) async {
    var notificationBody = {
      "to": token,
      "priority": "high",
      "notification": {"title": title, "body": body, "sound": "default"},
      'data': data,
    };
    dio.options.headers.addAll(headersList);
    await dio.post(url.toString(), data: json.encode(notificationBody));
  }
}
