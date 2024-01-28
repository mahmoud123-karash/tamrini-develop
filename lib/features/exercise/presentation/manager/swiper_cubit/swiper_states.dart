abstract class SwiperStates {}

class InitialSwiperState extends SwiperStates {}

class LoadingShowImageState extends SwiperStates {}

class SuccessShowImageState extends SwiperStates {}

class ErrorShowImageState extends SwiperStates {
  final String error;

  ErrorShowImageState(this.error);
}

class LoadingShowVedioState extends SwiperStates {}

class SuccessShowVedioState extends SwiperStates {}

class ErrorShowVedioState extends SwiperStates {
  final String error;

  ErrorShowVedioState(this.error);
}

class SaveIndexState extends SwiperStates {}
