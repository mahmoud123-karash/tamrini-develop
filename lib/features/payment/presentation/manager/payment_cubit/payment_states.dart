abstract class PaymentStates {}

class InitialPaymentState extends PaymentStates {}

class LoadingCreateTransactionIdState extends PaymentStates {}

class SucessCreateTransactionIdState extends PaymentStates {
  final String? id;
  SucessCreateTransactionIdState(this.id);
}

class ErrorCreateTransactionIdState extends PaymentStates {
  final String message;

  ErrorCreateTransactionIdState(this.message);
}
