import 'package:tamrini/features/gym/data/models/subscriber_model/subscriber_model.dart';

abstract class SubscriberStates {}

class InitialSubscribersState extends SubscriberStates {}

class LoadingGetSubscribersState extends SubscriberStates {}

class SucessGetSubscribersState extends SubscriberStates {
  final List<SubscriberModel> list;

  SucessGetSubscribersState(this.list);
}

class ErrorGetSubscribersState extends SubscriberStates {
  final String message;

  ErrorGetSubscribersState(this.message);
}
