import 'dart:developer';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/chat/presentation/views/chat_screen.dart';
import 'package:tamrini/features/notification/presentation/views/notification_screen.dart';
import 'package:tamrini/features/profile/data/models/profile_model/profile_model.dart';
import 'package:tamrini/features/questions/data/models/user_model/user_model.dart';
import 'package:tamrini/features/questions/presentation/views/answers_screen.dart';
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

void onMessageOpenedApp({required BuildContext context}) {
  FirebaseMessaging.onMessageOpenedApp.listen(
    (event) {
      openNotification(event, context);
    },
  );
}

void getintil(context) async {
  RemoteMessage? remoteMessage =
      await FirebaseMessaging.instance.getInitialMessage();
  if (remoteMessage != null) {
    openNotification(remoteMessage, context);
  } else {
    log("No Message");
  }
}

void openNotification(RemoteMessage event, BuildContext context) {
  if (event.data['type'] == 'system') {
    navigateTo(context, const NotificationScreen(value: 'system'));
  }

  if (event.data['type'] == 'message') {
    navigateTo(context, const ChatScreen());
  }
  if (event.data['type'] == 'notification') {
    var box = Hive.box<ProfileModel>(profileBox);
    ProfileModel model = box.values.toList().first;
    String type = CacheHelper.getData(key: 'usertype') ?? '';
    String token = CacheHelper.getData(key: 'deviceToken') ?? '';
    String uid = CacheHelper.getData(key: 'uid') ?? '';
    navigateTo(
      context,
      AnswersScreen(
        uid: event.data['uid'],
        model: UserModel(
          name: model.name,
          image: model.image,
          token: token,
          role: type,
          uid: uid,
          isSubscribedToTrainer: model.isSubscribedToTrainer,
          isBanned: model.isBanned,
          isSubscribedToGym: model.isSubscribedToGym,
        ),
      ),
    );
  }
}
