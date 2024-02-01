import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/features/diet_food/data/models/diet_food_model.dart/diet_food_model.dart';
import 'package:tamrini/features/diet_food/domain/repo/diet_food_repo.dart';
import 'package:tamrini/features/diet_food/presentation/manager/article_cubit/diet_food_states.dart';

class DietFoodCubit extends Cubit<DietFoodStates> {
  DietFoodCubit(this.dietFoodRePo) : super(InitialDietFoodState());

  static DietFoodCubit get(context) => BlocProvider.of(context);

  final DietFoodRepo dietFoodRePo;

  void getData() async {
    emit(LoadingGetDietFoodState());
    var result = await dietFoodRePo.get();
    result.fold(
      (message) {
        emit(ErrorGetDietFoodState(message));
      },
      (list) {
        emit(SucessGetDietFoodState(list));
      },
    );
  }

  void addMeal({
    required String name,
    required String description,
    required List<String> paths,
  }) async {
    emit(LoadingGetDietFoodState());
    var result = await dietFoodRePo.addMeal(
        name: name, description: description, paths: paths);
    result.fold(
      (message) {
        emit(ErrorGetDietFoodState(message));
      },
      (list) {
        emit(SucessGetDietFoodState(list));
      },
    );
  }

  void editMeal({
    required String name,
    required String description,
    required List<String> paths,
    required DietFoodModel oldModel,
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
        emit(SucessGetDietFoodState(list));
      },
    );
  }

  void removeMeal({
    required List<String> assets,
    required String id,
  }) async {
    emit(LoadingGetDietFoodState());
    var result = await dietFoodRePo.removeMeal(
      id: id,
      assets: assets,
    );
    result.fold(
      (message) {
        emit(ErrorGetDietFoodState(message));
      },
      (list) {
        emit(SucessGetDietFoodState(list));
      },
    );
  }
}
