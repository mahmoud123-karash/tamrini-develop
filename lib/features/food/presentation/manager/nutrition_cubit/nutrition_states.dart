import 'package:tamrini/features/food/data/models/nutrition_model/nutrition_model.dart';

abstract class NutritionStates {}

class InitialNutritionState extends NutritionStates {}

class LoadingGetNutritionState extends NutritionStates {}

class SucessGetNutritionState extends NutritionStates {
  final List<NutritionModel> list;

  SucessGetNutritionState(this.list);
}

class ErrorGetNutritionState extends NutritionStates {
  final String message;

  ErrorGetNutritionState(this.message);
}
