import '../../../data/models/reminder_model/reminder_model.dart';

abstract class ReminderStates {}

class InitialReminderState extends ReminderStates {}

class LoadingGetRemindersState extends ReminderStates {}

class SucessGetRemindersState extends ReminderStates {
  final List<ReminderModel> list;

  SucessGetRemindersState(this.list);
}

class ErrorGetRemindersState extends ReminderStates {
  final String message;

  ErrorGetRemindersState(this.message);
}
