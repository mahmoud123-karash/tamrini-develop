import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/features/trainee/data/models/trainee_model/trainee_exercises_model.dart';
import 'course_states.dart';

class CourseCubit extends Cubit<CourseStates> {
  CourseCubit() : super(InitialCourseState());

  static CourseCubit get(context) => BlocProvider.of(context);

  List<TraineeExerciseModel> sutList = [];
  List<TraineeExerciseModel> sunList = [];
  List<TraineeExerciseModel> monList = [];
  List<TraineeExerciseModel> tueList = [];
  List<TraineeExerciseModel> wenList = [];
  List<TraineeExerciseModel> thrueList = [];
  List<TraineeExerciseModel> friList = [];

  int num = 0;
  List<TraineeExerciseModel> list = [];

  void selectExercise({required TraineeExerciseModel model}) {
    list.add(model);
    fillList(model);
    emit(SuccessSelectExerciseState());
  }

  void unSelectExercise({required String id}) {
    TraineeExerciseModel model =
        list.firstWhere((element) => element.exerciseId == id);
    list.remove(model);
    emptyList(model, num);
    emit(SuccessUnSelectExerciseState());
  }

  void removeExercise({required String id, required int index}) {
    TraineeExerciseModel model =
        list.firstWhere((element) => element.exerciseId == id);
    emptyList(model, index);
    emit(SuccessUnSelectExerciseState());
  }

  void fillList(TraineeExerciseModel model) {
    switch (num) {
      case 0:
        sutList.add(model);
        break;
      case 1:
        sunList.add(model);
        break;
      case 2:
        monList.add(model);
        break;
      case 3:
        tueList.add(model);
        break;
      case 4:
        wenList.add(model);
        break;
      case 5:
        thrueList.add(model);
        break;
      case 6:
        friList.add(model);
        break;
      default:
        break;
    }
  }

  void emptyList(TraineeExerciseModel model, int num) {
    switch (num) {
      case 0:
        sutList.remove(model);
        break;
      case 1:
        sunList.remove(model);
        break;
      case 2:
        monList.remove(model);
        break;
      case 3:
        tueList.remove(model);
        break;
      case 4:
        wenList.remove(model);
        break;
      case 5:
        thrueList.remove(model);
        break;
      case 6:
        friList.remove(model);
        break;
      default:
        break;
    }
  }

  bool checkThreeListsNotEmpty() {
    int count = 0;

    if (sutList.isNotEmpty) {
      count++;
    }

    if (sunList.isNotEmpty) {
      count++;
    }

    if (monList.isNotEmpty) {
      count++;
    }

    if (tueList.isNotEmpty) {
      count++;
    }

    if (wenList.isNotEmpty) {
      count++;
    }

    if (thrueList.isNotEmpty) {
      count++;
    }

    if (friList.isNotEmpty) {
      count++;
    }

    return count >= 3;
  }
}
