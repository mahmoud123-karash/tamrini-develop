import 'package:tamrini/features/trainee/data/models/trainee_model/trainee_model.dart';

abstract class UserCourseStates {}

class InitialCourseState extends UserCourseStates {}

class LoadingGetCourseState extends UserCourseStates {}

class SuccessGetCourseState extends UserCourseStates {
  final TraineeModel model;

  SuccessGetCourseState(this.model);
}

class ErrorGetCourseState extends UserCourseStates {
  final String message;

  ErrorGetCourseState(this.message);
}
