abstract class RegisterStates {}

class InitialRegisterState extends RegisterStates {}

class LoadingRegisterState extends RegisterStates {}

class SuccessRegisterState extends RegisterStates {}

class ErrorRegisterState extends RegisterStates {
  final String message;

  ErrorRegisterState(this.message);
}
