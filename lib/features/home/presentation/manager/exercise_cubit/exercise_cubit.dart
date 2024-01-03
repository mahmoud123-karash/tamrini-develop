import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/features/home/domain/repo/home_repo.dart';
import 'package:tamrini/features/home/presentation/manager/exercise_cubit/exercise_states.dart';

class ExerciseCubit extends Cubit<ExerciseStates> {
  ExerciseCubit(this.homeRepo) : super(InitialExerciseState());

  static ExerciseCubit get(context) => BlocProvider.of(context);

  final HomeRepo homeRepo;

  void getData() async {
    emit(LoadingGetExerciseState());
    var result = await homeRepo.getExercises();
    result.fold(
      (message) {
        if (kDebugMode) {
          print(message);
        }
        emit(ErrorGetExerciseState(message));
      },
      (list) {
        emit(SucessGetExerciseState(list));
      },
    );
  }
}
