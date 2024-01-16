abstract class LocationStates {}

class InitialLocationState extends LocationStates {}

class LocationChangedLoadingState extends LocationStates {}

class LocationChangedSuccessState extends LocationStates {
  final String message;

  LocationChangedSuccessState(this.message);
}

class LocationChangedErrorState extends LocationStates {
  final String message;

  LocationChangedErrorState(this.message);
}
