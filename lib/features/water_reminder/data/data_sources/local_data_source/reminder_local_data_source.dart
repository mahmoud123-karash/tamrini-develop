import 'package:hive_flutter/hive_flutter.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/features/water_reminder/data/models/reminder_model/reminder_model.dart';

abstract class ReminderLocalDataSource {
  List<ReminderModel> get();
}

class ReminderLocalDataSourceImpl extends ReminderLocalDataSource {
  @override
  List<ReminderModel> get() {
    var box = Hive.box<ReminderModel>(reminderBox);
    return box.values.toList();
  }
}
