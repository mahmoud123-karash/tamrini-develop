import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/features/exercise/domain/repo/exercise_repo.dart';
import 'package:tamrini/features/exercise/presentation/manager/home_exercise_cubit/home_exercise_states.dart';

class HomeExerciseCubit extends Cubit<HomeExersiceStates> {
  HomeExerciseCubit(this.exerciseRepo) : super(InitialHomeExerciseState());

  static HomeExerciseCubit get(context) => BlocProvider.of(context);

  final ExerciseRepo exerciseRepo;

  void getData() async {
    emit(LoadingGetHomeExerciseState());
    var result = await exerciseRepo.get();
    result.fold(
      (message) {
        if (kDebugMode) {
          print(message);
        }
        emit(ErrorGetHomeExerciseState(message));
      },
      (list) {
        emit(SucessGetHomeExerciseState(list));
      },
    );
  }
}
