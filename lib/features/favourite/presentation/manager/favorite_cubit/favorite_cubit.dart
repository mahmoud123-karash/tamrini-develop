import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/features/favourite/data/models/meal_model/meal_model.dart';
import 'package:tamrini/features/favourite/domain/repo/favorite_repo.dart';
import 'favorite_states.dart';

class FavoriteCubit extends Cubit<FavoriteStates> {
  FavoriteCubit(this.favoriteRepo) : super(InitialFavoriteState());

  static FavoriteCubit get(context) => BlocProvider.of(context);
  final FavoriteRepo favoriteRepo;

  void getData() async {
    var result = await favoriteRepo.getFavoriteMeals();

    result.fold(
      (message) {
        emit(ErrorGetFavoritesState(message));
      },
      (list) {
        emit(SucessGetFavoritesState(list));
      },
    );
  }

  void addFavoriteMeal({
    required num carbs,
    required num protein,
    required num fat,
    required num calories,
    required String id,
    required String name,
  }) async {
    var result = await favoriteRepo.addFavoriteMeal(
      carbs: carbs,
      protein: protein,
      fat: fat,
      name: name,
      calories: calories,
      id: id,
    );

    result.fold(
      (message) {
        emit(ErrorGetFavoritesState(message));
      },
      (list) {
        emit(SucessGetFavoritesState(list));
      },
    );
  }

  void removeFavoriteMeal({
    required MealModel meal,
  }) async {
    var result = await favoriteRepo.removeFavoriteMeal(
      meal: meal,
    );
    result.fold(
      (message) {
        emit(ErrorGetFavoritesState(message));
      },
      (list) {
        emit(SucessGetFavoritesState(list));
      },
    );
  }
}
