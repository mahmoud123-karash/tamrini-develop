import 'package:tamrini/features/questions/data/models/diet_food_model.dart/diet_food_model.dart';

abstract class DietFoodStates {}

class InitialDietFoodState extends DietFoodStates {}

class LoadingGetDietFoodState extends DietFoodStates {}

class SucessGetDietFoodState extends DietFoodStates {
  final List<DietFoodModel> list;

  SucessGetDietFoodState(this.list);
}

class ErrorGetDietFoodState extends DietFoodStates {
  final String message;

  ErrorGetDietFoodState(this.message);
}
