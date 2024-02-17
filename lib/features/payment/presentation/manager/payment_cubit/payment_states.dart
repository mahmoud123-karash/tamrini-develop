abstract class PaymentStates {}

class InitialPaymentState extends PaymentStates {}

class LoadingCreateTransactionIdState extends PaymentStates {}

class SucessCreateTransactionIdState extends PaymentStates {
  final String? token;
  SucessCreateTransactionIdState(this.token);
}

class ErrorCreateTransactionIdState extends PaymentStates {
  final String message;

  ErrorCreateTransactionIdState(this.message);
}
