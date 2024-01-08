import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/features/questions/domain/repo/diet_food_repo.dart';
import 'package:tamrini/features/questions/presentation/manager/article_cubit/diet_food_states.dart';

class DietFoodCubit extends Cubit<DietFoodStates> {
  DietFoodCubit(this.dietFoodRePo) : super(InitialDietFoodState());

  static DietFoodCubit get(context) => BlocProvider.of(context);

  final DietFoodRepo dietFoodRePo;

  void getData() async {
    emit(LoadingGetDietFoodState());
    var result = await dietFoodRePo.get();
    result.fold(
      (message) {
        if (kDebugMode) {
          print(message);
        }
        emit(ErrorGetDietFoodState(message));
      },
      (list) {
        emit(SucessGetDietFoodState(list));
      },
    );
  }
}
