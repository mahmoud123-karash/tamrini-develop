import 'package:tamrini/features/trainee/data/models/sub_model/trainee_model.dart';

abstract class TraineeStates {}

class InitialTraineeState extends TraineeStates {}

class LoadingGetTraineesState extends TraineeStates {}

class SucessGetTraineesState extends TraineeStates {
  final List<TraineeModel> list;

  SucessGetTraineesState(this.list);
}

class ErrorGetTraineesState extends TraineeStates {
  final String message;

  ErrorGetTraineesState(this.message);
}
