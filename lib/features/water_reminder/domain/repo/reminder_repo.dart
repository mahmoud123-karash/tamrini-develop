import 'package:dartz/dartz.dart';
import 'package:tamrini/features/water_reminder/data/models/reminder_model/reminder_model.dart';

abstract class ReminderRepo {
  Either<String, List<ReminderModel>> getReminders();
}
