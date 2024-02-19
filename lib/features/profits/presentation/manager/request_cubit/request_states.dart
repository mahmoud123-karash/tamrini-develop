abstract class RequestStates {}

class InitialRequestState extends RequestStates {}

class LoadingRequestState extends RequestStates {}

class SuccessRequestState extends RequestStates {}

class ErrorRequestState extends RequestStates {
  final String message;
  ErrorRequestState(this.message);
}
