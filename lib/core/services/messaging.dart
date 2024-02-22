import 'dart:developer';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:tamrini/core/cache/save_data.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/services/services.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/admin/presentation/views/admin_profits_screen.dart';
import 'package:tamrini/features/gym/presentation/manager/gym_cubit/gym_cubit.dart';
import 'package:tamrini/features/gym/presentation/views/gym_owner_screen.dart';
import 'package:tamrini/features/notification/presentation/manager/notification_cubit/notification_cubit.dart';
import 'package:tamrini/features/notification/presentation/views/notification_screen.dart';
import 'package:tamrini/features/order/presentation/manager/order_cubit/order_cubit.dart';
import 'package:tamrini/features/order/presentation/views/order_details_screen.dart';
import 'package:tamrini/features/profits/presentation/manager/profits_cubit/profits_cubit.dart';
import 'package:tamrini/features/promotion/presentation/views/promotion_screen.dart';
import 'package:tamrini/features/questions/presentation/views/answers_screen.dart';
import 'package:tamrini/features/store/presentation/manager/store_cubit/store_cubit.dart';
import 'package:tamrini/features/trainee/presentation/manager/trainee_cubit/trainee_cubit.dart';
import 'package:tamrini/features/trainee/presentation/manager/user_course_cubit.dart/user_course_cubit.dart';
import 'package:tamrini/features/trainee/presentation/views/trainer_subscribers_screen.dart';
import 'package:tamrini/features/trainee/presentation/views/training_course_screen.dart';
import 'package:tamrini/features/trainer/presentation/manager/trainer_cubit/trainers_cubit.dart';
import 'package:tamrini/features/trainer/presentation/views/trainer_profile_screen.dart';

import '../../features/store/presentation/views/store_owner_screen.dart';

void onMessage({
  required BuildContext context,
}) {
  FirebaseMessaging.onMessage.listen(
    (RemoteMessage message) async {
      NotificationCubit.get(context).getData();
      if (message.data['subType'] == 'store') {
        StoreCubit.get(context).getData();
      }
      if (message.data['subType'] == 'gym') {
        GymCubit.get(context).getData(update: false);
      }
      if (message.data['subType'] == 'order') {
        OrderCubit.get(context).getData();
      }
      if (message.data['subType'] == 'promotion_accept') {
        log(message.data['promotionType']);
        saveUserType(message.data['promotionType'] ?? '');
        if (message.data['promotionType'] == 'trainer') {
          TrainersCubit.get(context).getData();
        }
      }
      if (message.data['subType'] == 'trainer') {
        TrainersCubit.get(context).getData();
      }
      if (message.data['subType'] == 'trainee' ||
          message.data['subType'] == 'renew_trainee') {
        String uid = CacheHelper.getData(key: 'uid') ?? '';
        TraineeCubit.get(context).getData(trainerId: uid);
      }
      if (message.data['subType'] == 'course') {
        UserCourseCubit.get(context).getCourse();
      }

      if (message.data['subType'] == 'follow') {
        String uid = CacheHelper.getData(key: 'uid') ?? '';
        TraineeCubit.get(context).getData(trainerId: uid);
      }

      if (message.data['subType'] == 'request_profits') {
        ProfitsCubit.get(context).getData();
      }

      if (message.data['subType'] == 'accept_profits') {
        if (message.data['user_role'] == 'trainer') {
          TrainersCubit.get(context).getData();
        } else if (message.data['user_role'] == 'gym owner') {
          GymCubit.get(context).getData(update: false);
        } else if (message.data['user_role'] == 'store owner') {
          StoreCubit.get(context).getData();
        }
      }
      if (message.data['subType'] != 'message') {
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

Future<void> onBackgroundMessageHandler(RemoteMessage message) async {
  if (message.data['subType'] == 'promotion_accept') {
    await CacheHelper.init();
    saveUserType(message.data['promotionType'] ?? '');
  }
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
  if (event.data['type'] == 'notification') {
    if (event.data['subType'] == 'question') {
      navigateTo(
        context,
        AnswersScreen(uid: event.data['uid'], model: getUserFromProfile()),
      );
    }
    if (event.data['subType'] == 'store') {
      navigateTo(context, const StoreOwnerScreen());
    }
    if (event.data['subType'] == 'gym') {
      navigateTo(context, const GymOwnerScreen());
    }
    if (event.data['subType'] == 'order') {
      navigateTo(context, OrderDetailsScreen(orderId: event.data['uid']));
    }

    if (event.data['subType'] == 'promotion') {
      navigateTo(context, const PromotionScreen());
    }

    if (event.data['subType'] == 'promotion_accept') {
      navigateTo(context, const NotificationScreen());
    }

    if (event.data['subType'] == 'trainer') {
      navigateTo(context, TrainerProfileScreen(id: event.data['uid']));
    }

    if (event.data['subType'] == 'trainee' ||
        event.data['subType'] == 'renew_trainee') {
      navigateTo(context, const TrainerSubscribersScreen());
    }

    if (event.data['subType'] == 'course') {
      navigateTo(context, const TrainingCourseScreen());
    }

    if (event.data['subType'] == 'follow') {
      navigateTo(context, const TrainerSubscribersScreen());
    }

    if (event.data['subType'] == 'message') {
      navigateTo(context, const NotificationScreen());
    }
    if (event.data['subType'] == 'request_profits') {
      navigateTo(context, const AdminProfitsScreen());
    }

    if (event.data['subType'] == 'accept_profits') {
      if (event.data['user_role'] == 'trainer') {
        navigateTo(context, TrainerProfileScreen(id: event.data['uid']));
      } else if (event.data['user_role'] == 'gym owner') {
        navigateTo(context, const GymOwnerScreen());
      } else if (event.data['user_role'] == 'store owner') {
        navigateTo(context, const StoreOwnerScreen());
      }
    }
  }
}
