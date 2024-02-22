import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/features/subscribtions/domain/repo/subscription_repo.dart';

import 'substription_states.dart';

class SubscriptionCubit extends Cubit<SubscriptionStates> {
  SubscriptionCubit(this.subscriptionRepo) : super(InitialSubscribtionsState());

  static SubscriptionCubit get(context) => BlocProvider.of(context);

  final SubscriptionRepo subscriptionRepo;
  void getSubscriptions() async {
    emit(LoadingGetUserSubState());
    var result = await subscriptionRepo.get();

    result.fold((message) {
      emit(ErrorGetUserSubState(message));
    }, (list) {
      emit(SucessGetUserSubState(list));
    });
  }

  void subUser({
    required String gymId,
    required int count,
    required num price,
    required num profits,
  }) async {
    emit(LoadingGetUserSubState());
    var result = await subscriptionRepo.subUser(
      gymId: gymId,
      count: count,
      price: price,
      profits: profits,
    );
    result.fold(
      (message) {
        emit(ErrorGetUserSubState(message));
      },
      (list) {
        if (!isClosed) {
          emit(SucessGetUserSubState(list));
        }
      },
    );
  }

  void renewSub({
    required String gymId,
    required String subId,
    required num price,
    required int count,
    required num profits,
  }) async {
    emit(LoadingGetUserSubState());
    var result = await subscriptionRepo.renewSub(
      gymId: gymId,
      subId: subId,
      count: count,
      profits: profits,
      price: price,
    );
    result.fold(
      (message) {
        emit(ErrorGetUserSubState(message));
      },
      (list) {
        if (!isClosed) {
          emit(SucessGetUserSubState(list));
        }
      },
    );
  }
}
