import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/features/trainee/data/models/trainee_model/trainee_model.dart';
import 'package:tamrini/features/trainee/domain/repo/trainee_repo.dart';

import 'trainee_states.dart';

class TraineeCubit extends Cubit<TraineeStates> {
  TraineeCubit(this.traineeRepo) : super(InitialTraineeState());

  static TraineeCubit get(context) => BlocProvider.of(context);

  final TraineeRepo traineeRepo;

  List<TraineeModel> trainees = [];
  void getData({required String trainerId}) async {
    emit(LoadingGetTraineesState());
    var result = await traineeRepo.getTrainees(trainerId: trainerId);
    result.fold(
      (message) {
        emit(ErrorGetTraineesState(message));
      },
      (list) {
        trainees = list;
        emit(SucessGetTraineesState(list));
      },
    );
  }

  void subUser({
    required String trainerId,
    required int traineesCount,
    required num profits,
  }) async {
    emit(LoadingGetTraineesState());
    var result = await traineeRepo.subUser(
        trainerId: trainerId, traineesCount: traineesCount, profits: profits);
    result.fold(
      (message) {
        emit(ErrorGetTraineesState(message));
      },
      (list) {
        trainees = list;
        emit(SucessGetTraineesState(list));
      },
    );
  }
}
