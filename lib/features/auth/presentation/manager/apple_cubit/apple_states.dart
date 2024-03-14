import 'package:tamrini/features/auth/domain/entities/user_entity.dart';

abstract class AppleStates {}

class InitialAppleSignInState extends AppleStates {}

class LoadingAppleSignInState extends AppleStates {}

class SuccessAppleSignInState extends AppleStates {
  final UserEntity user;
  SuccessAppleSignInState(this.user);
}

class ErrorAppleSignInState extends AppleStates {
  final String messsage;
  ErrorAppleSignInState(this.messsage);
}
