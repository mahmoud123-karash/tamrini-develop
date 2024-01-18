import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/features/food/domain/repo/food_repo.dart';
import 'package:tamrini/features/food/presentation/manager/nutrition_cubit/nutrition_states.dart';

class NutritionCubit extends Cubit<NutritionStates> {
  NutritionCubit(this.foodRepo) : super(InitialNutritionState());

  static NutritionCubit get(context) => BlocProvider.of(context);

  final FoodRepo foodRepo;

  void getData({required String id}) async {
    emit(LoadingGetNutritionState());
    var result = await foodRepo.getNutritions(id: id);
    result.fold(
      (message) {
        if (kDebugMode) {
          print(message);
        }
        emit(ErrorGetNutritionState(message));
      },
      (list) {
        emit(SucessGetNutritionState(list));
      },
    );
  }
}
