abstract class ChatStates {}

class InitialChatState extends ChatStates {}

class LoadingSendMessageState extends ChatStates {}

class SuccessSendMessageState extends ChatStates {}

class ErrorSendMessageState extends ChatStates {
  final String message;

  ErrorSendMessageState(this.message);
}
