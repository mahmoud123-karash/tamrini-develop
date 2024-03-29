import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/services/search.dart';
import 'package:tamrini/features/nutrition/data/models/nutrition_model/nutrition_model.dart';
import 'package:tamrini/features/nutrition/presentation/manager/select_cubit.dart/select_states.dart';

class SelectCubit extends Cubit<SelectStates> {
  SelectCubit() : super(InitialSelecteState());

  static SelectCubit get(context) => BlocProvider.of(context);
  List<NutritionModel> searchList = [];

  void search(value, List<NutritionModel> list) {
    searchList = searchNutrition(value, list);
    log(searchList.length.toString());
    emit(SearchNutritionState());
  }

  int selctedMeal = 0;
  int selectedWieght = 50;
  NutritionModel model = NutritionModel(
    title: '',
    calories: 0.0,
    proteins: 0.0,
    fats: 0.0,
    carbs: 0.0,
    categryId: '',
    id: '',
    writerUid: '',
    user: null,
  );

  void selectmeal(NutritionModel meal) {
    model = meal;
    emit(SelectNutritionState());
  }

  void selectWieght(int wieght) {
    selectedWieght = wieght;
    emit(SelectWieghtState());
  }

  void reset() {
    selctedMeal = 0;
    selectedWieght = 50;
    model = NutritionModel(
      title: '',
      calories: 0.0,
      proteins: 0.0,
      fats: 0.0,
      carbs: 0.0,
      id: '',
      writerUid: '',
    );
    emit(ResetState());
  }
}
