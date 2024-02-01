import 'package:tamrini/core/models/subscription_model/subscription_model.dart';
import 'package:tamrini/core/models/user_model/user_model.dart';

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

class LoadingGetUserSubState extends UserStates {}

class SucessGetUserSubState extends UserStates {
  final List<SubscriptionModel> list;

  SucessGetUserSubState(this.list);
}

class ErrorGetUserSubState extends UserStates {
  final String message;
  ErrorGetUserSubState(this.message);
}
