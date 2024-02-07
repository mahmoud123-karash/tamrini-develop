abstract class RatingStates {}

class InitialRatingState extends RatingStates {}

class LoadingRateProductState extends RatingStates {}

class SucessRateProductState extends RatingStates {}

class ErrorRateProductState extends RatingStates {
  final String message;

  ErrorRateProductState(this.message);
}
