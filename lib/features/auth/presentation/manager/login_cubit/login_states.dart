abstract class LoginStates {}

class InitialLoginState extends LoginStates {}

class LoadingLoginState extends LoginStates {}

class SuccessLoginState extends LoginStates {
  final String uid;

  SuccessLoginState(this.uid);
}

class ErrorLoginState extends LoginStates {
  final String messsage;

  ErrorLoginState(this.messsage);
}
