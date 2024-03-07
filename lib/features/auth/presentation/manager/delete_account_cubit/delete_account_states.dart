abstract class DeleteAccountStates {}

class InitialDeleteAccountState extends DeleteAccountStates {}

class LoadingDeleteAccountState extends DeleteAccountStates {}

class SuccessDeleteAccountState extends DeleteAccountStates {}

class ReAuthAccountState extends DeleteAccountStates {}

class ErrorDeleteAccountState extends DeleteAccountStates {
  final String messsage;
  ErrorDeleteAccountState(this.messsage);
}
