import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/features/trainee/data/models/trainee_model/course_model.dart';
import 'course_states.dart';

class CourseCubit extends Cubit<CourseStates> {
  CourseCubit() : super(InitialCourseState());

  static CourseCubit get(context) => BlocProvider.of(context);

  List<CourseModel> sutList = [];
  List<CourseModel> sunList = [];
  List<CourseModel> monList = [];
  List<CourseModel> tueList = [];
  List<CourseModel> wenList = [];
  List<CourseModel> thrueList = [];
  List<CourseModel> friList = [];

  int num = 0;
  List<CourseModel> list = [];

  void selectExercise({required CourseModel model}) {
    list.add(model);
    selectList(num, list);
    emit(SuccessSelectExerciseState());
  }

  void unSelectExercise({required CourseModel model}) {
    list.remove(model);
    selectList(num, list);
    emit(SuccessUnSelectExerciseState());
  }

  void selectList(int num, List<CourseModel> list) {
    if (num == 1) {
      sutList = list;
    } else if (num == 2) {
      sunList = list;
    } else if (num == 3) {
      monList = list;
    } else if (num == 4) {
      tueList = list;
    } else if (num == 5) {
      wenList = list;
    } else if (num == 6) {
      thrueList = list;
    } else {
      friList = list;
    }
  }
}
