abstract class ResetStates {}

class InitialResetState extends ResetStates {}

class LoadingResetState extends ResetStates {}

class SuccessResetState extends ResetStates {}

class ErrorResetState extends ResetStates {
  final String error;

  ErrorResetState(this.error);
}
