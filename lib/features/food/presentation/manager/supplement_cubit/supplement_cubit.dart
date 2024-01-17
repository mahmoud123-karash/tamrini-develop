import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/features/food/domain/repo/food_repo.dart';
import 'package:tamrini/features/food/presentation/manager/supplement_cubit/supplement_states.dart';

class SupplementCubit extends Cubit<SupplementStates> {
  SupplementCubit(this.foodRepo) : super(InitialSupplementState());

  static SupplementCubit get(context) => BlocProvider.of(context);

  final FoodRepo foodRepo;

  void getData() async {
    emit(LoadingGetSupplementState());
    var result = await foodRepo.get();
    result.fold(
      (message) {
        if (kDebugMode) {
          print(message);
        }
        emit(ErrorGetSupplementState(message));
      },
      (list) {
        emit(SucessGetSupplementState(list));
      },
    );
  }
}
