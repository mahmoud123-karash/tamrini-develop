import 'package:tamrini/features/trainer/data/models/trainer_model/trainer_model.dart';

abstract class TrainersStates {}

class InitialTrainersState extends TrainersStates {}

class LoadingGetTrainersState extends TrainersStates {}

class SucessGetTrainersState extends TrainersStates {
  final List<TrainerModel> list;

  SucessGetTrainersState(this.list);
}

class ErrorGetTrainersState extends TrainersStates {
  final String message;

  ErrorGetTrainersState(this.message);
}
