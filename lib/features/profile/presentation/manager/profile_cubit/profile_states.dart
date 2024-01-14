import 'package:tamrini/features/profile/data/models/profile_model/profile_model.dart';

abstract class ProfileStates {}

class InitialProfileState extends ProfileStates {}

class LoadingGetProfileState extends ProfileStates {}

class SucessGetProfileState extends ProfileStates {
  final ProfileModel model;

  SucessGetProfileState(this.model);
}

class ErrorGetProfileState extends ProfileStates {
  final String message;

  ErrorGetProfileState(this.message);
}
