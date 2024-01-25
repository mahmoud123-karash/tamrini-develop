import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/features/suggest_exercise/domain/repo/suggest_repo.dart';
import 'package:tamrini/features/suggest_exercise/presentation/manager/suggest_cubit/suggest_states.dart';

class SuggestCubit extends Cubit<SuggestStates> {
  SuggestCubit(this.suggestRepo) : super(InitialSuggestState());

  static SuggestCubit get(context) => BlocProvider.of(context);

  final SuggestRepo suggestRepo;

  void getData() async {
    emit(LoadingGetSuggestedExercisesState());
    var result = await suggestRepo.getSuggestedExercises();

    result.fold(
      (message) {
        emit(ErrorGetSuggestedExercisestate(message));
      },
      (list) {
        emit(SucessGetSuggestedExercisesState(list));
      },
    );
  }

  void suggestExercise({
    required String title,
    required String url,
    required String imagePath,
  }) async {
    emit(LoadingSuggestState());
    var result = await suggestRepo.suggestExercise(
      title: title,
      url: url,
      imagePath: imagePath,
    );
    result.fold(
      (message) {
        emit(ErrorSuggestState(message));
      },
      (r) {
        emit(SucessSuggestState());
      },
    );
  }
}
