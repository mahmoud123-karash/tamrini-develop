import 'package:tamrini/features/questions/data/models/user_model/user_model.dart';

abstract class UserStates {}

class InitialUserState extends UserStates {}

class LoadingGetUserState extends UserStates {}

class SucessGetUserState extends UserStates {
  final UserModel model;

  SucessGetUserState(this.model);
}

class ErrorGetUserState extends UserStates {
  final String message;

  ErrorGetUserState(this.message);
}
