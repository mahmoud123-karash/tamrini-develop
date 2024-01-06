import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/features/home/domain/repo/home_repo.dart';
import 'package:tamrini/features/home/presentation/manager/gym_cubit/gym_states.dart';

class GymCubit extends Cubit<GymStates> {
  GymCubit(this.homeRepo) : super(InitialGymState());

  static GymCubit get(context) => BlocProvider.of(context);

  final HomeRepo homeRepo;

  void getData({
    required bool update,
  }) async {
    emit(LoadingGetGymsState());
    var result = await homeRepo.getGyms(update: update);
    result.fold(
      (message) {
        log(message);
        emit(ErrorGetGymsState(message));
      },
      (list) {
        emit(SucessGetGymsState(list));
      },
    );
  }
}
