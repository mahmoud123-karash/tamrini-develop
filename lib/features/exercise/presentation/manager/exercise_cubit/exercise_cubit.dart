import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/features/exercise/domain/repo/exercise_repo.dart';
import 'package:tamrini/features/exercise/data/models/exercise_model/data_model.dart';
import 'package:tamrini/features/exercise/presentation/manager/exercise_cubit/exercise_states.dart';

import '../../../data/models/exercise_model/exercise_model.dart';

class ExerciseCubit extends Cubit<ExerciseStates> {
  ExerciseCubit(this.exerciseRepo) : super(InitialExerciseState());

  static ExerciseCubit get(context) => BlocProvider.of(context);

  final ExerciseRepo exerciseRepo;

  List<ExerciseModel> exercises = [];

  void getData() async {
    emit(LoadingGetExerciseState());
    var result = await exerciseRepo.getExercises();
    result.fold(
      (message) {
        if (kDebugMode) {
          print(message);
        }
        emit(ErrorGetExerciseState(message));
      },
      (list) {
        exercises = list;
        emit(SucessGetExerciseState(list));
      },
    );
  }

  void addNewSection({
    required String title,
    required int order,
    required String imagePth,
  }) async {
    emit(LoadingGetExerciseState());
    var result = await exerciseRepo.addSection(
      list: exercises,
      title: title,
      order: order,
      imagePth: imagePth,
    );
    result.fold(
      (message) {
        if (kDebugMode) {
          print(message);
        }
        emit(ErrorGetExerciseState(message));
      },
      (list) {
        exercises = list;
        emit(SucessGetExerciseState(list));
      },
    );
  }

  void editSection({
    required ExerciseModel oldModel,
    required String title,
    required int order,
    required String imagePth,
    required String id,
    required List<DataModel> data,
  }) async {
    emit(LoadingGetExerciseState());
    var result = await exerciseRepo.editSection(
      list: exercises,
      oldModel: oldModel,
      title: title,
      order: order,
      imagePth: imagePth,
      data: data,
      id: id,
    );
    result.fold(
      (message) {
        if (kDebugMode) {
          print(message);
        }
        emit(ErrorGetExerciseState(message));
      },
      (list) {
        exercises = list;
        emit(SucessGetExerciseState(list));
      },
    );
  }
}
