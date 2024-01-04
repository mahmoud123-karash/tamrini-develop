import 'package:tamrini/features/home/data/models/store_model/store_model.dart';

abstract class StoreStates {}

class InitialStoresState extends StoreStates {}

class LoadingGetStoresState extends StoreStates {}

class SucessGetStoresState extends StoreStates {
  final List<StoreModel> list;

  SucessGetStoresState(this.list);
}

class ErrorGetStoresState extends StoreStates {
  final String message;

  ErrorGetStoresState(this.message);
}
