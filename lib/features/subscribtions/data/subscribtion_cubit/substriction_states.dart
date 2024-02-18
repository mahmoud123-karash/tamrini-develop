import 'package:tamrini/features/subscribtions/data/models/subscription_model/subscription_model.dart';

abstract class SubscribtionStates {}

class InitialSubscribtionsState extends SubscribtionStates {}

class LoadingGetSubscribtionsState extends SubscribtionStates {}

class SucessGetSubscribtionsState extends SubscribtionStates {
  final List<SubscriptionModel> list;

  SucessGetSubscribtionsState(this.list);
}

class ErrorGetSubscribtionsState extends SubscribtionStates {
  final String message;

  ErrorGetSubscribtionsState(this.message);
}
