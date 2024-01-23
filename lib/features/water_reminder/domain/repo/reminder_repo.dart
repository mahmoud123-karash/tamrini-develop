import 'package:dartz/dartz.dart';
import 'package:tamrini/features/water_reminder/data/models/reminder_model/reminder_model.dart';

abstract class ReminderRepo {
  Either<String, List<ReminderModel>> getReminders();
  Future<Either<String, List<ReminderModel>>> addReminder({
    required ReminderModel model,
  });
  Future<Either<String, List<ReminderModel>>> removeReminder({
    required int index,
  });
  Future<Either<String, List<ReminderModel>>> updateReminder({
    required int index,
    required ReminderModel model,
  });
}
