import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/my_day/data/models/day_model/day_model.dart';
import 'package:tamrini/features/my_day/data/models/day_model/nutrient.dart';
import 'package:tamrini/features/my_day/domain/repo/my_day_repo.dart';
import 'package:tamrini/features/my_day/presentation/manager/day_cubit/day_states.dart';

import '../../../../../generated/l10n.dart';
import '../../../data/models/day_model/calculator_model.dart';

class DayCubit extends Cubit<DayStates> {
  DayCubit(this.myDayRepo) : super(InitialDayState());

  static DayCubit get(context) => BlocProvider.of(context);

  DayModel getDay({required String id}) {
    var box = Hive.box<DayModel>(dayBox);
    List<DayModel> list =
        box.values.toList().where((element) => element.id == id).toList();
    return list.first;
  }

  CalculatorModel getNeeds({required String id}) {
    var box = Hive.box<DayModel>(dayBox);
    List<DayModel> list =
        box.values.toList().where((element) => element.id == id).toList();
    DayModel model = list.first;
    num calories = model.model.calories -
        model.nutrients.values
            .fold(0, (sum, nutrient) => sum + nutrient.calories);
    num protein = model.model.protein -
        model.nutrients.values
            .fold(0, (sum, nutrient) => sum + nutrient.protein);
    num fat = model.model.fat -
        model.nutrients.values.fold(0, (sum, nutrient) => sum + nutrient.fat);
    num carbs = model.model.carbs -
        model.nutrients.values.fold(0, (sum, nutrient) => sum + nutrient.carbs);
    return CalculatorModel(
      calories: calories,
      protein: protein,
      fat: fat,
      carbs: carbs,
    );
  }

  final MyDayRepo myDayRepo;
  void getData() async {
    emit(LoadingGetDayState());
    var result = await myDayRepo.getData();
    result.fold(
      (message) {
        if (kDebugMode) {
          print(message);
        }
        emit(ErrorGetDayState(message));
      },
      (list) {
        emit(SucessGetDayState(list));
      },
    );
  }

  void addToday() async {
    var result = await myDayRepo.addToday();
    result.fold(
      (message) {
        if (kDebugMode) {
          print(message);
        }
        emit(ErrorGetDayState(message));
      },
      (list) {
        emit(SucessGetDayState(list));
      },
    );
  }

  void recalulate({
    required CalculatorModel calculatorModel,
    required String id,
  }) async {
    emit(LoadingGetDayState());
    var result = await myDayRepo.reCalculate(
        model: getDay(id: id), calculatorModel: calculatorModel);
    result.fold(
      (message) {
        if (kDebugMode) {
          print(message);
        }
        emit(ErrorGetDayState(message));
      },
      (list) {
        emit(SucessGetDayState(list));
      },
    );
  }

  void addMeal({
    required String id,
    required Nutrient nutrient,
    required String name,
  }) async {
    emit(LoadingGetDayState());
    var result = await myDayRepo.addMealToDay(
        model: getDay(id: id), nutrient: nutrient, name: name);
    result.fold(
      (message) {
        if (kDebugMode) {
          print(message);
        }
        emit(ErrorGetDayState(message));
      },
      (list) {
        emit(SucessGetDayState(list));
      },
    );
  }

  void removeMeal({
    required String id,
    required String name,
    required BuildContext context,
  }) async {
    var result =
        await myDayRepo.removeMealFromDay(model: getDay(id: id), name: name);
    result.fold(
      (message) {
        if (kDebugMode) {
          print(message);
        }
        showSnackBar(context, message);
        emit(ErrorGetDayState(message));
      },
      (list) {
        showSnackBar(context, S.of(context).success_remove_meal);
        emit(SucessGetDayState(list));
      },
    );
  }
}
