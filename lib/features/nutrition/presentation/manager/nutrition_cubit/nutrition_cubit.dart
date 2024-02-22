import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/nutrition/data/models/nutrition_model/nutrition_model.dart';
import 'package:tamrini/features/nutrition/domain/repo/nutrition_repo.dart';
import 'package:tamrini/features/nutrition/presentation/manager/nutrition_cubit/nutrition_states.dart';
import 'package:tamrini/generated/l10n.dart';

class NutritionCubit extends Cubit<NutritionStates> {
  NutritionCubit(this.nuritionRepo) : super(InitialNutritionState());

  static NutritionCubit get(context) => BlocProvider.of(context);

  final NuritionRepo nuritionRepo;

  List<NutritionModel> nutritions = [];

  void getData({required String id, bool isUpate = false}) async {
    List<NutritionModel> list =
        nutritions.where((element) => element.categryId == id).toList();
    if (list.isNotEmpty && isUpate == false) {
      emit(SucessGetNutritionState(list));
    } else {
      var result = await nuritionRepo.getNutritions(id: id);
      result.fold(
        (message) {
          emit(ErrorGetNutritionState(message));
        },
        (list) {
          nutritions = list;
          emit(SucessGetNutritionState(list));
        },
      );
    }
  }

  void addNutrition({
    required String categoryId,
    required String name,
    required double protien,
    required double fat,
    required double carb,
    required double calories,
    required BuildContext context,
  }) async {
    emit(LoadingGetNutritionState());
    var result = await nuritionRepo.addNutrition(
        list: nutritions,
        categoryId: categoryId,
        name: name,
        protien: protien,
        fat: fat,
        carb: carb,
        calories: calories);
    result.fold(
      (message) {
        emit(ErrorGetNutritionState(message));
      },
      (list) {
        nutritions = list;
        Navigator.pop(context);
        showSnackBar(context, S.of(context).success_add_a);
        emit(SucessGetNutritionState(list));
      },
    );
  }

  void editNutrition({
    required NutritionModel oldModel,
    required String categoryId,
    required String name,
    required double protien,
    required double fat,
    required double carb,
    required double calories,
    required BuildContext context,
  }) async {
    emit(LoadingGetNutritionState());
    var result = await nuritionRepo.editNutrition(
      list: nutritions,
      oldModel: oldModel,
      categoryId: categoryId,
      name: name,
      protien: protien,
      fat: fat,
      carb: carb,
      calories: calories,
    );
    result.fold(
      (message) {
        log(message);
        emit(ErrorGetNutritionState(message));
      },
      (list) {
        nutritions = list;
        Navigator.pop(context);
        showSnackBar(context, S.of(context).success_edit_a);
        emit(SucessGetNutritionState(list));
      },
    );
  }

  void removeNutrition({
    required String categoryId,
    required String id,
    required BuildContext context,
  }) async {
    var result = await nuritionRepo.removeNutrition(
      list: nutritions,
      id: id,
      categoryId: categoryId,
    );
    result.fold(
      (message) {
        emit(ErrorGetNutritionState(message));
      },
      (list) {
        nutritions = list;
        showSnackBar(context, S.of(context).success_remove);
        emit(SucessGetNutritionState(list));
      },
    );
  }
}
