import 'package:tamrini/features/auth/domain/entities/user_entity.dart';

abstract class GoogleStates {}

class InitialGoogleSignInState extends GoogleStates {}

class LoadingGoogleSignInState extends GoogleStates {}

class SuccessGoogleSignInState extends GoogleStates {
  final UserEntity user;

  SuccessGoogleSignInState(this.user);
}

class ErrorGoogleSignInState extends GoogleStates {
  final String messsage;

  ErrorGoogleSignInState(this.messsage);
}
