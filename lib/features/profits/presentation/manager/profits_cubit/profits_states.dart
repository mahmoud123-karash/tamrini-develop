import 'package:tamrini/features/profits/data/models/profits_model/profits_model.dart';

abstract class ProfitsStates {}

class InitialProfitsState extends ProfitsStates {}

class LoadingGetProfitsRequestsState extends ProfitsStates {}

class SuccessGetProfitsRequestsState extends ProfitsStates {
  final List<ProfitsModel> list;
  SuccessGetProfitsRequestsState(this.list);
}

class ErrorGetProfitsRequestsState extends ProfitsStates {
  final String message;
  ErrorGetProfitsRequestsState(this.message);
}
