import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/features/home_exercise/domain/repo/home_exercise_repo.dart';
import 'package:tamrini/features/home_exercise/presentation/manager/home_exercise_cubit/home_exercise_states.dart';

class HomeExerciseCubit extends Cubit<HomeExersiceStates> {
  HomeExerciseCubit(this.homeExerciseRepo) : super(InitialHomeExerciseState());

  static HomeExerciseCubit get(context) => BlocProvider.of(context);

  final HomeExerciseRepo homeExerciseRepo;

  void getData() async {
    emit(LoadingGetHomeExerciseState());
    var result = await homeExerciseRepo.get();
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
