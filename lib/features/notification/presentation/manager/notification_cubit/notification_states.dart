import 'package:tamrini/features/notification/data/models/notification_model/notification_model.dart';

abstract class NotificationStates {}

class InitialNotificationsState extends NotificationStates {}

class LoadingGetNotificationsState extends NotificationStates {}

class SucessGetNotificationsState extends NotificationStates {
  final List<NotificationModel> list;
  SucessGetNotificationsState(this.list);
}

class ErrorGetNotificationsState extends NotificationStates {
  final String message;
  ErrorGetNotificationsState(this.message);
}
