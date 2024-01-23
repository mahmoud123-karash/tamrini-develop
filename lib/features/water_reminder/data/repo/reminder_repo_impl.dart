import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/utils/awesome_notification.dart';
import 'package:tamrini/features/water_reminder/data/data_sources/local_data_source/reminder_local_data_source.dart';
import 'package:tamrini/features/water_reminder/data/models/reminder_model/reminder_model.dart';
import 'package:tamrini/features/water_reminder/domain/repo/reminder_repo.dart';
import 'package:tamrini/generated/l10n.dart';
import 'package:tamrini/utils/widgets/global%20Widgets.dart';

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
      setNotification(
        title: S.of(navigationKey.currentContext!).time_to_drink,
        body:
            "${model.time.format(navigationKey.currentContext!)}-${model.quantiy}",
        id: model.id,
        hour: model.time.hour,
        minute: model.time.minute,
      );
      return right(box.values.toList());
    } on Exception catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, List<ReminderModel>>> removeReminder({
    required ReminderModel model,
  }) async {
    try {
      var box = Hive.box<ReminderModel>(reminderBox);
      List<ReminderModel> list = box.values.toList();
      list.remove(model);
      await box.clear();
      await box.addAll(list);
      return right(box.values.toList());
    } on Exception catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, List<ReminderModel>>> updateReminder({
    required ReminderModel model,
    required ReminderModel oldModel,
  }) async {
    try {
      var box = Hive.box<ReminderModel>(reminderBox);
      List<ReminderModel> list = box.values.toList();
      list.remove(oldModel);
      list.add(model);
      await box.clear();
      box.addAll(list);
      if (model.isActive) {
        setNotification(
          title: S.of(navigationKey.currentContext!).time_to_drink,
          body:
              "${model.time.format(navigationKey.currentContext!)}-${model.quantiy}",
          id: model.id,
          hour: model.time.hour,
          minute: model.time.minute,
        );
      } else {
        cancelNotification(id: model.id);
      }
      return right(box.values.toList());
    } on Exception catch (e) {
      return left(e.toString());
    }
  }
}
