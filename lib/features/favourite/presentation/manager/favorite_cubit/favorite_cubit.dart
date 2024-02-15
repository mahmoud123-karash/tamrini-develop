import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/features/favourite/data/models/meal_model/meal_model.dart';
import 'package:tamrini/features/favourite/domain/repo/favorite_repo.dart';
import 'favorite_states.dart';

class FavoriteCubit extends Cubit<FavoriteStates> {
  FavoriteCubit(this.favoriteRepo) : super(InitialFavoriteState());

  static FavoriteCubit get(context) => BlocProvider.of(context);
  final FavoriteRepo favoriteRepo;

  void getData() async {
    emit(LoadingGetFavoritesState());
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
    required MealModel meal,
  }) async {
    var result = await favoriteRepo.addFavoriteMeal(
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
