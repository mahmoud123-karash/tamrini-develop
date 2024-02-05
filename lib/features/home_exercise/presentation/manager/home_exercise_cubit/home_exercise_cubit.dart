import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/home_exercise/data/models/home_exercise/exercise_data.dart';
import 'package:tamrini/features/home_exercise/data/models/home_exercise/home_exercise_model.dart';
import 'package:tamrini/features/home_exercise/domain/repo/home_exercise_repo.dart';
import 'package:tamrini/features/home_exercise/presentation/manager/home_exercise_cubit/home_exercise_states.dart';
import 'package:tamrini/features/home_exercise/presentation/views/home_exercise_details_screen.dart';
import 'package:tamrini/features/home_exercise/presentation/views/home_exercise_details_with_youtub_screen.dart';
import 'package:tamrini/generated/l10n.dart';

class HomeExerciseCubit extends Cubit<HomeExerciseStates> {
  HomeExerciseCubit(this.homeExerciseRepo) : super(InitialHomeExerciseState());

  static HomeExerciseCubit get(context) => BlocProvider.of(context);

  final HomeExerciseRepo homeExerciseRepo;

  List<HomeExerciseModel> models = [];

  HomeExerciseModel getSection(id) {
    return models.where((element) => element.id == id).toList().first;
  }

  Data? getExercise(id) {
    List<Data> list = [];
    for (var element in models) {
      list.addAll(element.data ?? []);
    }
    List<Data> finalList = list.where((element) => element.id == id).toList();
    if (finalList.isEmpty) {
      return null;
    } else {
      return finalList.first;
    }
  }

  void getData() async {
    emit(LoadingGetHomeExerciseState());
    var result = await homeExerciseRepo.get();
    result.fold(
      (message) {
        emit(ErrorGetHomeExerciseState(message));
      },
      (list) {
        models = list;
        emit(SucessGetHomeExerciseState(list));
      },
    );
  }

  void addSection({
    required String name,
    required int order,
    required List<String> paths,
    required BuildContext context,
  }) async {
    emit(LoadingGetHomeExerciseState());
    var result = await homeExerciseRepo.addSection(
      name: name,
      order: order,
      paths: paths,
    );
    result.fold(
      (message) {
        emit(ErrorGetHomeExerciseState(message));
      },
      (list) {
        models = list;
        Navigator.pop(context);
        showSnackBar(context, S.of(context).success_add_a);
        emit(SucessGetHomeExerciseState(list));
      },
    );
  }

  void editSection({
    required String name,
    required String id,
    required int order,
    required List<String> paths,
    required BuildContext context,
  }) async {
    emit(LoadingGetHomeExerciseState());
    var result = await homeExerciseRepo.editSection(
      name: name,
      section: getSection(id),
      order: order,
      paths: paths,
    );
    result.fold(
      (message) {
        emit(ErrorGetHomeExerciseState(message));
      },
      (list) {
        models = list;
        Navigator.pop(context);
        showSnackBar(context, S.of(context).success_edit_a);
        emit(SucessGetHomeExerciseState(list));
      },
    );
  }

  void addExercise({
    required String name,
    required String description,
    required String youtubUri,
    required List<String> paths,
    required String id,
    required BuildContext context,
  }) async {
    emit(LoadingGetHomeExerciseState());
    var result = await homeExerciseRepo.addExercise(
      name: name,
      description: description,
      youtubUri: youtubUri,
      paths: paths,
      section: getSection(id),
    );
    result.fold(
      (message) {
        emit(ErrorGetHomeExerciseState(message));
      },
      (list) {
        models = list;
        Navigator.pop(context);
        showSnackBar(context, S.of(context).success_add_a);
        emit(SucessGetHomeExerciseState(list));
      },
    );
  }

  void editExercise({
    required String name,
    required String description,
    required String youtubUri,
    required List<String> paths,
    required Data oldData,
    required String id,
    required BuildContext context,
  }) async {
    emit(LoadingGetHomeExerciseState());
    var result = await homeExerciseRepo.editExercise(
      name: name,
      description: description,
      youtubUri: youtubUri,
      paths: paths,
      oldData: oldData,
      section: getSection(id),
    );
    result.fold(
      (message) {
        emit(ErrorGetHomeExerciseState(message));
      },
      (list) {
        models = list;
        if (youtubUri == '') {
          navigateToAndReplace(
              context, HomeExerciseDetailsScreen(id: oldData.id, isAll: false));
        } else {
          navigateToAndReplace(
              context,
              HomeExerciseDetailsWithYoutubScreen(
                id: oldData.id,
                isAll: false,
                vedio: youtubUri,
              ));
        }
        showSnackBar(context, S.of(context).success_edit_a);
        emit(SucessGetHomeExerciseState(list));
      },
    );
  }

  void removeExercise({
    required Data oldData,
    required String id,
    required String message,
  }) async {
    var result = await homeExerciseRepo.removeExercise(
      oldData: oldData,
      section: getSection(id),
    );
    result.fold(
      (message) {
        getData();
        emit(ErrorGetHomeExerciseState(message));
      },
      (list) {
        models = list;
        showToast(message);
        emit(SucessGetHomeExerciseState(list));
      },
    );
  }
}
