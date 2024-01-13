import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:tamrini/utils/widgets/global%20Widgets.dart';

void onMessage({required VoidCallback function}) {
  FirebaseMessaging.onMessage.listen(
    (RemoteMessage message) async {
      function();
      if (message.data['type'] == 'system') {
        AwesomeDialog(
          context: navigationKey.currentContext!,
          dialogType: DialogType.info,
          animType: AnimType.bottomSlide,
          title: message.notification?.title,
          desc: message.notification?.body,
          btnCancelOnPress: () {},
          btnOkOnPress: () {},
        ).show();
      } else {
        AwesomeNotifications().createNotification(
          content: NotificationContent(
            id: message.notification.hashCode,
            channelKey: 'basic_channel',
            actionType: ActionType.Default,
            title: message.notification!.title,
            body: message.notification!.body,
          ),
        );
      }
    },
  );
}
