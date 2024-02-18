import 'package:tamrini/features/subscribtions/data/models/subscription_model/subscription_model.dart';

abstract class SubscriptionStates {}

class InitialSubscribtionsState extends SubscriptionStates {}

class LoadingGetUserSubState extends SubscriptionStates {}

class SucessGetUserSubState extends SubscriptionStates {
  final List<SubscriptionModel> list;
  SucessGetUserSubState(this.list);
}

class ErrorGetUserSubState extends SubscriptionStates {
  final String message;
  ErrorGetUserSubState(this.message);
}
