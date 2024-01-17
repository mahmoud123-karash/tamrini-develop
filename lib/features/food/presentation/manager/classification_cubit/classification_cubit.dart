import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/features/food/domain/repo/food_repo.dart';
import 'package:tamrini/features/food/presentation/manager/classification_cubit/classification_states.dart';

class ClassificationCubit extends Cubit<ClassificationStates> {
  ClassificationCubit(this.foodRepo) : super(InitialClassificationState());

  static ClassificationCubit get(context) => BlocProvider.of(context);

  final FoodRepo foodRepo;

  void getData() async {
    emit(LoadingGetClassificationState());
    var result = await foodRepo.getClassifications();
    result.fold(
      (message) {
        if (kDebugMode) {
          print(message);
        }
        emit(ErrorGetClassificationState(message));
      },
      (list) {
        emit(SucessGetClassificationState(list));
      },
    );
  }
}
