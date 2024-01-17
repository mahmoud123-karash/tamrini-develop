import 'package:tamrini/features/food/data/models/supplement_model/supplement_model.dart';

abstract class SupplementStates {}

class InitialSupplementState extends SupplementStates {}

class LoadingGetSupplementState extends SupplementStates {}

class SucessGetSupplementState extends SupplementStates {
  final List<SupplementModel> list;

  SucessGetSupplementState(this.list);
}

class ErrorGetSupplementState extends SupplementStates {
  final String message;

  ErrorGetSupplementState(this.message);
}
