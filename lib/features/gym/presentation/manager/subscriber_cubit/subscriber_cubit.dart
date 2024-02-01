import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/features/gym/domain/repo/gym_repo.dart';
import 'package:tamrini/features/gym/presentation/manager/subscriber_cubit/subscriber_states.dart';

class SubscriberCubit extends Cubit<SubscriberStates> {
  SubscriberCubit(this.gymRepo) : super(InitialSubscribersState());

  static SubscriberCubit get(context) => BlocProvider.of(context);

  final GymRepo gymRepo;

  void getSubscribers({
    required String gymId,
  }) async {
    emit(LoadingGetSubscribersState());
    var result = await gymRepo.getSubscribers(gymId: gymId);
    result.fold(
      (message) {
        log(message);
        emit(ErrorGetSubscribersState(message));
      },
      (list) {
        if (!isClosed) {
          emit(SucessGetSubscribersState(list));
        }
      },
    );
  }

  void subUser({
    required String gymId,
    required int count,
  }) async {
    var result = await gymRepo.subUser(
      gymId: gymId,
      count: count,
    );

    result.fold(
      (message) {
        log(message);
        emit(ErrorGetSubscribersState(message));
      },
      (list) {
        if (!isClosed) {
          emit(SucessGetSubscribersState(list));
        }
      },
    );
  }
}
