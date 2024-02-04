import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/features/nutrition/domain/repo/nutrition_repo.dart';
import 'package:tamrini/features/nutrition/presentation/manager/classification_cubit/classification_states.dart';

class ClassificationCubit extends Cubit<ClassificationStates> {
  ClassificationCubit(this.nuritionRepo) : super(InitialClassificationState());

  static ClassificationCubit get(context) => BlocProvider.of(context);

  final NuritionRepo nuritionRepo;

  void getData() async {
    emit(LoadingGetClassificationState());
    var result = await nuritionRepo.getClassifications();
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
