import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/features/notification/data/models/notification_model/notification_model.dart';
import 'package:tamrini/features/notification/domain/repo/notification_repo.dart';
import 'package:tamrini/features/notification/presentation/manager/notification_cubit/notification_states.dart';

class NotificationCubit extends Cubit<NotificationStates> {
  NotificationCubit(this.repo) : super(InitialNotificationsState());

  static NotificationCubit get(context) => BlocProvider.of(context);

  final NotificationRepo repo;

  void getData() async {
    emit(LoadingGetNotificationsState());
    var result = await repo.get();
    result.fold(
      (message) {
        if (kDebugMode) {
          print(message);
        }
        emit(ErrorGetNotificationsState(message));
      },
      (list) {
        emit(SucessGetNotificationsState(list));
      },
    );
  }

  void updateNotification({
    required List<NotificationModel> list,
    required String lable,
  }) async {
    var result = await repo.updateNotification(list: list, lable: lable);
    result.fold(
      (message) {
        emit(ErrorGetNotificationsState(message));
      },
      (list) {
        emit(SucessGetNotificationsState(list));
      },
    );
  }
}
