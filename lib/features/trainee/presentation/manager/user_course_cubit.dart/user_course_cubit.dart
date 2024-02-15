import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/features/trainee/data/models/trainee_model/follow_up_model.dart';
import 'package:tamrini/features/trainee/data/models/trainee_model/trainee_model.dart';
import 'package:tamrini/features/trainee/domain/repo/trainee_repo.dart';
import 'user_course_states.dart';

class UserCourseCubit extends Cubit<UserCourseStates> {
  UserCourseCubit(this.traineeRepo) : super(InitialCourseState());

  static UserCourseCubit get(context) => BlocProvider.of(context);
  final TraineeRepo traineeRepo;

  void getCourse() async {
    emit(LoadingGetCourseState());
    var result = await traineeRepo.getUserCourse();
    result.fold(
      (message) {
        emit(ErrorGetCourseState(message));
      },
      (model) {
        emit(SuccessGetCourseState(model));
      },
    );
  }

  void addNewFollow({
    required TraineeModel traineeModel,
    required List<String> paths,
    required List<FollowUpData> followUpData,
  }) async {
    emit(LoadingGetCourseState());
    var result = await traineeRepo.addNewFollow(
      traineeModel: traineeModel,
      paths: paths,
      followUpData: followUpData,
    );
    result.fold(
      (message) {
        emit(ErrorGetCourseState(message));
      },
      (model) {
        emit(SuccessGetCourseState(model));
      },
    );
  }

  void rateTrainer({
    required TraineeModel traineeModel,
  }) async {
    emit(LoadingGetCourseState());
    var result = await traineeRepo.rateTrainer(
      traineeModel: traineeModel,
    );
    result.fold(
      (message) {
        emit(ErrorGetCourseState(message));
      },
      (model) {
        emit(SuccessGetCourseState(model));
      },
    );
  }
}
