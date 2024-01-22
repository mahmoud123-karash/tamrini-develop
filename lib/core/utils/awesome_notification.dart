import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';

void initializeNotifications() {
  AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
        channelGroupKey: 'basic_channel_group',
        channelKey: 'basic_channel',
        channelName: 'Basic notifications',
        channelDescription: 'Notification channel for basic tests',
        defaultColor: appColor,
        ledColor: Colors.white,
      )
    ],
    debug: true,
  );
}

void setRepedtedNotification({
  required int secondes,
  required String title,
}) async {
  String localTimeZone =
      await AwesomeNotifications().getLocalTimeZoneIdentifier();
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: 100,
      channelKey: 'basic_channel',
      actionType: ActionType.Default,
      title: title,
      notificationLayout: NotificationLayout.BigPicture,
      category: NotificationCategory.Reminder,
      bigPicture: 'asset://assets/images/water_cover.jpg',
      autoDismissible: false,
      fullScreenIntent: true,
      wakeUpScreen: true,
    ),
    schedule: NotificationInterval(
      interval: secondes,
      timeZone: localTimeZone,
      preciseAlarm: true,
      repeats: true,
    ),
  );
}

void cancelNotification({required int id}) async {
  await AwesomeNotifications().cancel(id);
}
