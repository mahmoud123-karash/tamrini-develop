import 'dart:developer';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/exercise/domain/repo/exercise_repo.dart';
import 'package:tamrini/features/exercise/data/models/exercise_model/data_model.dart';
import 'package:tamrini/features/exercise/presentation/manager/exercise_cubit/exercise_states.dart';
import 'package:tamrini/features/exercise/presentation/views/exercise_details_screen.dart';
import 'package:tamrini/generated/l10n.dart';

import '../../../data/models/exercise_model/exercise_model.dart';

class ExerciseCubit extends Cubit<ExerciseStates> {
  ExerciseCubit(this.exerciseRepo) : super(InitialExerciseState());

  static ExerciseCubit get(context) => BlocProvider.of(context);

  final ExerciseRepo exerciseRepo;

  List<ExerciseModel> exercises = [];

  ExerciseModel getExercise({required String id}) {
    List<ExerciseModel> list =
        exercises.where((element) => element.id == id).toList();
    return list.first;
  }

  DataModel? getExerciseData({
    required String dataId,
  }) {
    List<DataModel> models = [];
    for (var element in exercises) {
      models.addAll(element.data!);
    }
    List<DataModel> finalList =
        models.where((element) => element.id == dataId).toList();
    if (finalList.isEmpty) {
      return null;
    }
    return finalList.first;
  }

  void getData() async {
    emit(LoadingGetExerciseState());
    var result = await exerciseRepo.getExercises();
    result.fold(
      (message) {
        log(message);
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
    required BuildContext context,
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
        log(message);
        emit(ErrorGetExerciseState(message));
      },
      (list) {
        exercises = list;
        Navigator.pop(context);
        showSnackBar(context, S.of(context).success_add_a);
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
    required BuildContext context,
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
        log(message);
        emit(ErrorGetExerciseState(message));
      },
      (list) {
        exercises = list;
        Navigator.pop(context);
        showSnackBar(context, S.of(context).success_edit_a);
        emit(SucessGetExerciseState(list));
      },
    );
  }

  void addExercise({
    required String id,
    required String title,
    required String description,
    required String youtubUrl,
    required String imagePath,
    required BuildContext context,
  }) async {
    emit(LoadingGetExerciseState());
    var result = await exerciseRepo.addExercise(
      list: exercises,
      exercise: getExercise(id: id),
      title: title,
      description: description,
      youtubUrl: youtubUrl,
      imagePath: imagePath,
    );
    result.fold(
      (message) {
        log(message);
        emit(ErrorGetExerciseState(message));
      },
      (list) {
        exercises = list;
        Navigator.pop(context);
        showSnackBar(context, S.of(context).success_add_a);
        emit(SucessGetExerciseState(list));
      },
    );
  }

  void editExercise({
    required String id,
    required String title,
    required String description,
    required String youtubUrl,
    required String imagePath,
    required DataModel oldData,
    required BuildContext context,
  }) async {
    emit(LoadingGetExerciseState());
    var result = await exerciseRepo.editExercise(
        list: exercises,
        exercise: getExercise(id: id),
        title: title,
        description: description,
        youtubUrl: youtubUrl,
        imagePath: imagePath,
        oldData: oldData);
    result.fold(
      (message) {
        log(message);
        emit(ErrorGetExerciseState(message));
      },
      (list) {
        exercises = list;
        showSnackBar(context, S.of(context).success_edit_a);
        navigateToAndReplace(
            context, DetailsScreen(vedio: youtubUrl, id: oldData.id!));
        emit(SucessGetExerciseState(list));
      },
    );
  }

  void removeExercise({
    required String exerciseId,
    required DataModel oldData,
    required String message,
  }) async {
    var result = await exerciseRepo.removeExercise(
      exercise: getExercise(id: exerciseId),
      oldData: oldData,
    );
    result.fold(
      (message) {
        log(message);
        emit(ErrorGetExerciseState(message));
      },
      (list) {
        exercises = list;
        showToast(message);
        emit(SucessGetExerciseState(list));
      },
    );
  }

  void moveExercise({
    required String exerciseId,
    required DataModel oldData,
    required ExerciseModel newCategory,
    required String message,
  }) async {
    var result = await exerciseRepo.moveExercise(
      list: exercises,
      newCategory: newCategory,
      oldCategory: getExercise(id: exerciseId),
      oldData: oldData,
    );
    result.fold(
      (message) {
        log(message);
        emit(ErrorGetExerciseState(message));
      },
      (list) {
        exercises = list;
        showToast(message);
        emit(SucessGetExerciseState(list));
      },
    );
  }
}
