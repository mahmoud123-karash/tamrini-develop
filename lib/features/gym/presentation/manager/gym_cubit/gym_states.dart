import 'package:tamrini/features/gym/data/models/gym_model/gym_model.dart';

abstract class GymStates {}

class InitialGymState extends GymStates {}

class LoadingGetGymsState extends GymStates {}

class SucessGetGymsState extends GymStates {
  final List<GymModel> list;

  SucessGetGymsState(this.list);
}

class ErrorGetGymsState extends GymStates {
  final String message;

  ErrorGetGymsState(this.message);
}
