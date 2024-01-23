import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/core/utils/awesome_notification.dart';
import 'package:tamrini/features/water_reminder/data/models/reminder_model/reminder_model.dart';
import 'package:tamrini/features/water_reminder/domain/repo/reminder_repo.dart';
import 'package:tamrini/features/water_reminder/presentaion/manager/reminder_cubit/reminder_states.dart';
import 'package:tamrini/generated/l10n.dart';

class ReminderCubit extends Cubit<ReminderStates> {
  ReminderCubit(this.reminderRepo) : super(InitialReminderState());

  static ReminderCubit get(context) => BlocProvider.of(context);
  final ReminderRepo reminderRepo;

  bool isActive = false;
  void getData() {
    emit(LoadingGetRemindersState());
    var result = reminderRepo.getReminders();
    result.fold(
      (message) {
        log(message);
        emit(ErrorGetRemindersState(message));
      },
      (list) {
        emit(SucessGetRemindersState(list));
      },
    );
  }

  void addReminder({
    required ReminderModel model,
    required BuildContext context,
  }) async {
    var result = await reminderRepo.addReminder(model: model);
    result.fold(
      (message) {
        log(message);
        emit(ErrorGetRemindersState(message));
      },
      (list) {
        Navigator.pop(context);
        emit(SucessGetRemindersState(list));
      },
    );
  }

  void removeReminder({
    required ReminderModel model,
    required BuildContext context,
  }) async {
    var result = await reminderRepo.removeReminder(model: model);
    result.fold(
      (message) {
        log(message);
        emit(ErrorGetRemindersState(message));
      },
      (list) {
        cancelNotification(id: model.id);
        showSnackBar(context, S.of(context).success_remove_reminder);
        emit(SucessGetRemindersState(list));
      },
    );
  }

  void updateReminder({
    required ReminderModel model,
    required ReminderModel oldModel,
    required BuildContext context,
  }) async {
    var result =
        await reminderRepo.updateReminder(oldModel: oldModel, model: model);
    result.fold(
      (message) {
        log(message);
        emit(ErrorGetRemindersState(message));
      },
      (list) {
        showSnackBar(context, S.of(context).success_update_reminder);
        emit(SucessGetRemindersState(list));
      },
    );
  }
}
