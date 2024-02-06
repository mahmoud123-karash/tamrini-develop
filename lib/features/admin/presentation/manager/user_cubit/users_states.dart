import 'package:tamrini/core/models/user_model/user_model.dart';

abstract class UsersStates {}

class InitialUserState extends UsersStates {}

class LoadingGetUsersState extends UsersStates {}

class SucessGetUsersState extends UsersStates {
  final List<UserModel> list;

  SucessGetUsersState(this.list);
}

class ErrorGetUsersState extends UsersStates {
  final String message;

  ErrorGetUsersState(this.message);
}
