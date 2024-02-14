import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/cache/save_data.dart';
import 'package:tamrini/features/trainee/data/models/trainee_model/course_model.dart';
import 'package:tamrini/features/trainee/data/models/trainee_model/food_model.dart';
import 'package:tamrini/features/trainee/data/models/trainee_model/trainee_model.dart';
import 'package:tamrini/features/trainee/domain/repo/trainee_repo.dart';

import 'trainee_states.dart';

class TraineeCubit extends Cubit<TraineeStates> {
  TraineeCubit(this.traineeRepo) : super(InitialTraineeState());

  static TraineeCubit get(context) => BlocProvider.of(context);

  final TraineeRepo traineeRepo;

  List<TraineeModel> trainees = [];
  TraineeModel getTrainee({required String id}) {
    return trainees.firstWhere((element) => element.uid == id);
  }

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
      trainerId: trainerId,
      traineesCount: traineesCount,
      profits: profits,
    );
    result.fold(
      (message) {
        emit(ErrorGetTraineesState(message));
      },
      (list) {
        saveTrainerId(trainerId);
        trainees = list;
        saveisEnd(false);
        emit(SucessGetTraineesState(list));
      },
    );
  }

  void reNewSubUser({
    required String trainerId,
    required int traineesCount,
    required num profits,
  }) async {
    emit(LoadingGetTraineesState());
    var result = await traineeRepo.reNewSubUser(
      trainerId: trainerId,
      traineesCount: traineesCount,
      profits: profits,
    );
    result.fold(
      (message) {
        emit(ErrorGetTraineesState(message));
      },
      (list) {
        trainees = list;
        saveisEnd(false);
        emit(SucessGetTraineesState(list));
      },
    );
  }

  void addNewCourse({
    required TraineeModel model,
    required DayWeekExercises dayWeekExercises,
    required String duration,
    required String notes,
    required String title,
  }) async {
    emit(LoadingGetTraineesState());
    var result = await traineeRepo.addNewCourse(
        model: model,
        dayWeekExercises: dayWeekExercises,
        duration: duration,
        notes: notes,
        title: title);
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

  void addSupplements({
    required TraineeModel model,
    required List<String> supplements,
  }) async {
    emit(LoadingGetTraineesState());
    var result = await traineeRepo.addSupplements(
      model: model,
      supplements: supplements,
    );
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

  void removeSupplements({
    required TraineeModel model,
    required String supplementId,
  }) async {
    emit(LoadingGetTraineesState());
    var result = await traineeRepo.removeSupplement(
      model: model,
      supplementId: supplementId,
    );
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

  void addDietCourse({
    required TraineeModel model,
    required String name,
    required String duration,
    required String satData,
    required String sunData,
    required String monData,
    required String wenData,
    required String tueData,
    required String thrusData,
    required String friData,
  }) async {
    emit(LoadingGetTraineesState());
    var result = await traineeRepo.addDietCourse(
      model: model,
      name: name,
      duration: duration,
      satData: satData,
      sunData: sunData,
      monData: monData,
      wenData: wenData,
      tueData: tueData,
      thrusData: thrusData,
      friData: friData,
    );
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

  void removeDietCourse({
    required TraineeModel model,
    required FoodModel foodModel,
  }) async {
    emit(LoadingGetTraineesState());
    var result = await traineeRepo.removeDietCourse(
      model: model,
      foodModel: foodModel,
    );
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
