import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/features/water_reminder/domain/repo/reminder_repo.dart';
import 'package:tamrini/features/water_reminder/presentaion/manager/reminder_cubit/reminder_states.dart';

class ReminderCubit extends Cubit<ReminderStates> {
  ReminderCubit(this.reminderRepo) : super(InitialReminderState());

  static ReminderCubit get(context) => BlocProvider.of(context);
  final ReminderRepo reminderRepo;
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
}
