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
}
