import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/features/trainer/data/models/trainer_model/trainer_model.dart';
import 'package:tamrini/features/trainer/domain/repo/trainer_repo.dart';
import 'package:tamrini/features/trainer/presentation/manager/trainer_cubit/trainers_states.dart';

class TrainersCubit extends Cubit<TrainersStates> {
  TrainersCubit(this.trainerRepo) : super(InitialTrainersState());

  static TrainersCubit get(context) => BlocProvider.of(context);

  final TrainerRepo trainerRepo;
  List<TrainerModel> trainers = [];
  void getData() async {
    emit(LoadingGetTrainersState());
    var result = await trainerRepo.get();
    result.fold(
      (message) {
        if (kDebugMode) {
          print(message);
        }
        emit(ErrorGetTrainersState(message));
      },
      (list) {
        trainers = list;
        log(list.length.toString());
        emit(SucessGetTrainersState(list));
      },
    );
  }

  TrainerModel getTrainer({required String uid}) {
    return trainers.where((element) => element.uid == uid).toList().first;
  }
}
