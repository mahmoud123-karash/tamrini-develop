import 'dart:developer';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/models/user_model/user_model.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/atricle/presentation/manager/article_cubit/articles_cubit.dart';
import 'package:tamrini/features/atricle/presentation/views/articles_details_screen.dart';
import 'package:tamrini/features/chat/presentation/views/chat_screen.dart';
import 'package:tamrini/features/diet_food/presentation/views/diet_food_details_screen.dart';
import 'package:tamrini/features/gym/presentation/views/gym_owner_screen.dart';
import 'package:tamrini/features/notification/presentation/manager/notification_cubit/notification_cubit.dart';
import 'package:tamrini/features/notification/presentation/views/notification_screen.dart';
import 'package:tamrini/features/profile/data/models/profile_model/profile_model.dart';
import 'package:tamrini/features/questions/presentation/views/answers_screen.dart';

void onMessage({
  required BuildContext context,
}) {
  FirebaseMessaging.onMessage.listen(
    (RemoteMessage message) async {
      NotificationCubit.get(context).getData();
      if (message.data['subType'] == 'article') {
        ArticlesCubit.get(context).getData();
      }
      AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: message.notification.hashCode,
          channelKey: 'basic_channel',
          actionType: ActionType.Default,
          title: message.notification!.title,
          body: message.notification!.body,
        ),
      );
    },
  );
}

Future<void> onBackgroundMessageHandler(RemoteMessage message) async {
  log('onBackgroundMessage');
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
    if (event.data['subType'] == 'question') {
      navigateTo(
        context,
        AnswersScreen(
          uid: event.data['uid'],
          model: UserModel(
            role: type,
            whatsApp: model.whatsApp ?? '',
            name: model.name,
            image: model.image,
            token: token,
            facebookUri: model.facebookUri,
            uid: uid,
            instgramUri: model.instgramUri,
            isBanned: model.isBanned,
            address: model.address,
            twiterUri: model.twiterUri,
            phone: model.phone,
          ),
        ),
      );
    }
    if (event.data['subType'] == 'article') {
      navigateTo(context, ArticlesDetailsScreen(id: event.data['uid']));
    }

    if (event.data['subType'] == 'ban_gym') {
      navigateTo(context, const GymOwnerScreen());
    }

    if (event.data['subType'] == 'diet_food') {
      navigateTo(context, DietFoodDetailsScreen(id: event.data['uid']));
    }
  }
}
