import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/trainer/data/models/trainer_model/gallery_model.dart';
import 'package:tamrini/features/trainer/data/models/trainer_model/trainer_model.dart';
import 'package:tamrini/features/trainer/domain/repo/trainer_repo.dart';
import 'package:tamrini/features/trainer/presentation/manager/trainer_cubit/trainers_states.dart';

class TrainersCubit extends Cubit<TrainersStates> {
  TrainersCubit(this.trainerRepo) : super(InitialTrainersState());

  static TrainersCubit get(context) => BlocProvider.of(context);

  final TrainerRepo trainerRepo;
  List<TrainerModel> trainers = [];

  TrainerModel? getTrainer({required String uid}) {
    List<TrainerModel> list =
        trainers.where((element) => element.uid == uid).toList();
    if (list.isEmpty) {
      return null;
    } else {
      return list.first;
    }
  }

  void getData() async {
    emit(LoadingGetTrainersState());
    var result = await trainerRepo.get();
    result.fold(
      (message) {
        emit(ErrorGetTrainersState(message));
      },
      (list) {
        List<TrainerModel> models = clearBannedTrainers(list);
        trainers = list;
        emit(SucessGetTrainersState(models));
      },
    );
  }

  void editTrainer({
    required TrainerModel trainer,
    required String description,
    required int price,
    required String fromH,
    required String toH,
  }) async {
    emit(LoadingGetTrainersState());
    var result = await trainerRepo.editTrainer(
        trainer: trainer,
        description: description,
        price: price,
        fromH: fromH,
        toH: toH);
    result.fold(
      (message) {
        emit(ErrorGetTrainersState(message));
      },
      (list) {
        List<TrainerModel> models = clearBannedTrainers(list);
        trainers = list;
        emit(SucessGetTrainersState(models));
      },
    );
  }

  void banTrainer({
    required bool isBanned,
    required String trainerId,
  }) async {
    emit(LoadingGetTrainersState());
    var result = await trainerRepo.banTrainer(
      isBanned: isBanned,
      trainerId: trainerId,
    );
    result.fold(
      (message) {
        emit(ErrorGetTrainersState(message));
      },
      (list) {
        List<TrainerModel> models = clearBannedTrainers(list);
        trainers = list;
        emit(SucessGetTrainersState(models));
      },
    );
  }

  void updateGallery({
    required TrainerModel trainer,
    required String imgBefore,
    required String imgAfter,
  }) async {
    emit(LoadingGetTrainersState());
    var result = await trainerRepo.updateGallery(
      trainer: trainer,
      imgBefore: imgBefore,
      imgAfter: imgAfter,
    );
    result.fold(
      (message) {
        emit(ErrorGetTrainersState(message));
      },
      (list) {
        List<TrainerModel> models = clearBannedTrainers(list);
        trainers = list;
        emit(SucessGetTrainersState(models));
      },
    );
  }

  void removeGallery({
    required TrainerModel trainer,
    required GalleryModel model,
    required String message,
  }) async {
    emit(LoadingGetTrainersState());
    var result = await trainerRepo.removeGallery(
      trainer: trainer,
      model: model,
    );
    result.fold(
      (message) {
        emit(ErrorGetTrainersState(message));
      },
      (list) {
        List<TrainerModel> models = clearBannedTrainers(list);
        trainers = list;
        showToast(message);
        emit(SucessGetTrainersState(models));
      },
    );
  }

  List<TrainerModel> clearBannedTrainers(List<TrainerModel> list) {
    List<TrainerModel> models = [];
    for (var element in list) {
      if (element.isBanned == false) {
        models.add(element);
      }
    }
    return models;
  }
}
