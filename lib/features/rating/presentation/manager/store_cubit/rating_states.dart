abstract class RatingStates {}

class InitialRatingState extends RatingStates {}

class LoadingRateProductState extends RatingStates {}

class SucessRateProductState extends RatingStates {}

class ErrorRateProductState extends RatingStates {
  final String message;

  ErrorRateProductState(this.message);
}

class LoadingRateTrainerState extends RatingStates {}

class SucessRateTrainerState extends RatingStates {}

class ErrorRateTrainerState extends RatingStates {
  final String message;
  ErrorRateTrainerState(this.message);
}
