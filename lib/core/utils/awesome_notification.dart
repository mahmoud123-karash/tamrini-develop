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
      id: 200000,
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

void setNotification({
  required String title,
  required String body,
  required int id,
  required int hour,
  required int minute,
}) async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: id,
      channelKey: 'basic_channel',
      actionType: ActionType.Default,
      title: title,
      body: body,
      notificationLayout: NotificationLayout.BigPicture,
      category: NotificationCategory.Reminder,
      bigPicture: 'asset://assets/images/water_cover.jpg',
      autoDismissible: false,
      fullScreenIntent: true,
      wakeUpScreen: true,
    ),
    schedule: NotificationCalendar.fromDate(
      date: nextScheduledDate(
        hour,
        minute,
      ),
      preciseAlarm: true,
      repeats: true,
    ),
  );
}

DateTime nextScheduledDate(hour, minute) {
  final DateTime now = DateTime.now();
  DateTime scheduledDate = DateTime(
    now.year,
    now.month,
    now.day,
    hour,
    minute,
  );
  if (scheduledDate.isBefore(now)) {
    scheduledDate = scheduledDate.add(const Duration(days: 1));
  }
  return scheduledDate;
}

void cancelNotification({required int id}) async {
  await AwesomeNotifications().cancel(id);
}
