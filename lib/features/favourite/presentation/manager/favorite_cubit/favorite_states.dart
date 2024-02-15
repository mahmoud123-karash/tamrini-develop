import 'package:tamrini/features/favourite/data/models/meal_model/meal_model.dart';

abstract class FavoriteStates {}

class InitialFavoriteState extends FavoriteStates {}

class LoadingGetFavoritesState extends FavoriteStates {}

class SucessGetFavoritesState extends FavoriteStates {
  final List<MealModel> list;

  SucessGetFavoritesState(this.list);
}

class ErrorGetFavoritesState extends FavoriteStates {
  final String message;
  ErrorGetFavoritesState(this.message);
}
