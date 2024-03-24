abstract class BanStates {}

class InitialBanState extends BanStates {}

class LoadingBanState extends BanStates {}

class SucessBanState extends BanStates {}

class ErrorBanState extends BanStates {
  final String message;
  ErrorBanState(this.message);
}
