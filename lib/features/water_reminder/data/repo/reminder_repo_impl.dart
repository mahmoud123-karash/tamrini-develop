import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/features/water_reminder/data/data_sources/local_data_source/reminder_local_data_source.dart';
import 'package:tamrini/features/water_reminder/data/models/reminder_model/reminder_model.dart';
import 'package:tamrini/features/water_reminder/domain/repo/reminder_repo.dart';

class ReminderRepoImpl extends ReminderRepo {
  final ReminderLocalDataSource reminderLocalDataSource;

  ReminderRepoImpl(this.reminderLocalDataSource);
  @override
  Either<String, List<ReminderModel>> getReminders() {
    try {
      List<ReminderModel> list = reminderLocalDataSource.get();

      return right(list);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, List<ReminderModel>>> addReminder({
    required ReminderModel model,
  }) async {
    try {
      var box = Hive.box<ReminderModel>(reminderBox);
      await box.add(model);
      return right(box.values.toList());
    } on Exception catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, List<ReminderModel>>> removeReminder({
    required int index,
  }) async {
    try {
      var box = Hive.box<ReminderModel>(reminderBox);

      await box.deleteAt(index);
      return right(box.values.toList());
    } on Exception catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, List<ReminderModel>>> updateReminder({
    required int index,
    required ReminderModel model,
  }) async {
    try {
      var box = Hive.box<ReminderModel>(reminderBox);
      await box.deleteAt(index);
      box.add(model);
      return right(box.values.toList());
    } on Exception catch (e) {
      return left(e.toString());
    }
  }
}
