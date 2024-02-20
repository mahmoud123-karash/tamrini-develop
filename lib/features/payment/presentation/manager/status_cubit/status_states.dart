abstract class StatusStates {}

class InitialStatusState extends StatusStates {}

class LoadingGetStatusState extends StatusStates {}

class SucessStatusState extends StatusStates {}

class FailedStatusState extends StatusStates {
  final String message;
  FailedStatusState(this.message);
}

class PendingStatusState extends StatusStates {}

class ErrorGetStatusState extends StatusStates {
  final String message;
  ErrorGetStatusState(this.message);
}
