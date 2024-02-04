import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/features/nutrition/domain/repo/nutrition_repo.dart';
import 'package:tamrini/features/nutrition/presentation/manager/nutrition_cubit/nutrition_states.dart';

class NutritionCubit extends Cubit<NutritionStates> {
  NutritionCubit(this.nuritionRepo) : super(InitialNutritionState());

  static NutritionCubit get(context) => BlocProvider.of(context);

  final NuritionRepo nuritionRepo;

  void getData({required String id}) async {
    emit(LoadingGetNutritionState());
    var result = await nuritionRepo.getNutritions(id: id);
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
