import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:geolocator/geolocator.dart';

void requestAppPermissions() {
  requestLocationPremissions();
  requestNotificationPremissions();
}

void requestLocationPremissions() async {
  bool serviceEnabled;
  LocationPermission permission;
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    Geolocator.openLocationSettings();
  }
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    Geolocator.requestPermission();
  }
  if (permission == LocationPermission.deniedForever) {
    Geolocator.requestPermission();
  }
}

void requestNotificationPremissions() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance..requestPermission();
  await messaging.setForegroundNotificationPresentationOptions(
      alert: true, badge: true, sound: true);

  await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: true,
    sound: true,
  );
  AppleNotificationSetting.enabled;
  AwesomeNotifications().requestPermissionToSendNotifications();
}
