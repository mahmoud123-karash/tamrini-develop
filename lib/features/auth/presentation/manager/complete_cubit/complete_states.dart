abstract class CompleteStates {}

class InitialCompleteState extends CompleteStates {}

class LoadingCompleteState extends CompleteStates {}

class SuccessCompleteState extends CompleteStates {
  final String uid;

  SuccessCompleteState(this.uid);
}

class ErrorCompleteState extends CompleteStates {
  final String messsage;

  ErrorCompleteState(this.messsage);
}

class SignOutState extends CompleteStates {}
