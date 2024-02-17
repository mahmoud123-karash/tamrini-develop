import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/diet_food/data/models/diet_food_model.dart/diet_food_model.dart';
import 'package:tamrini/features/diet_food/domain/repo/diet_food_repo.dart';
import 'package:tamrini/features/diet_food/presentation/manager/diet_food_cubit/diet_food_states.dart';
import 'package:tamrini/generated/l10n.dart';

class DietFoodCubit extends Cubit<DietFoodStates> {
  DietFoodCubit(this.dietFoodRePo) : super(InitialDietFoodState());

  static DietFoodCubit get(context) => BlocProvider.of(context);

  final DietFoodRepo dietFoodRePo;

  List<DietFoodModel> foods = [];

  List<DietFoodModel> getfood(String id) {
    return foods.where((element) => element.id == id).toList();
  }

  List<DietFoodModel> getUserFood(String uid) {
    return foods.where((element) => element.writerUid == uid).toList();
  }

  void getData() async {
    emit(LoadingGetDietFoodState());
    var result = await dietFoodRePo.get();
    result.fold(
      (message) {
        emit(ErrorGetDietFoodState(message));
      },
      (list) {
        foods = list;
        List<DietFoodModel> models = clearRefusedFood(list);
        emit(SucessGetDietFoodState(models));
      },
    );
  }

  List<DietFoodModel> clearRefusedFood(List<DietFoodModel> list) {
    List<DietFoodModel> models = [];
    for (var element in list) {
      if (element.isPending == false) {
        models.add(element);
      }
    }
    return models;
  }

  void addMeal({
    required String name,
    required String description,
    required List<String> paths,
    required BuildContext context,
  }) async {
    emit(LoadingGetDietFoodState());
    var result = await dietFoodRePo.addMeal(
        name: name, description: description, paths: paths);
    result.fold(
      (message) {
        emit(ErrorGetDietFoodState(message));
      },
      (list) {
        foods = list;
        List<DietFoodModel> models = clearRefusedFood(list);
        showSnackBar(context, S.of(context).success_add_a);
        Navigator.pop(context);
        emit(SucessGetDietFoodState(models));
      },
    );
  }

  void editMeal({
    required String name,
    required String description,
    required List<String> paths,
    required DietFoodModel oldModel,
    required BuildContext context,
  }) async {
    emit(LoadingGetDietFoodState());
    var result = await dietFoodRePo.editMeal(
      name: name,
      description: description,
      paths: paths,
      oldModel: oldModel,
    );
    result.fold(
      (message) {
        emit(ErrorGetDietFoodState(message));
      },
      (list) {
        List<DietFoodModel> models = clearRefusedFood(list);
        foods = list;
        showSnackBar(context, S.of(context).success_edit_a);
        Navigator.pop(context);
        emit(SucessGetDietFoodState(models));
      },
    );
  }

  void removeMeal({
    required List<String> assets,
    required String id,
    required BuildContext context,
  }) async {
    var result = await dietFoodRePo.removeMeal(
      id: id,
      assets: assets,
    );
    result.fold(
      (message) {
        getData();
        emit(ErrorGetDietFoodState(message));
      },
      (list) {
        List<DietFoodModel> models = clearRefusedFood(list);
        foods = list;
        showSnackBar(context, S.of(context).success_remove);
        emit(SucessGetDietFoodState(models));
      },
    );
  }
}
