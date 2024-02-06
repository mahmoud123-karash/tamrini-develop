import 'package:tamrini/features/order/data/models/order_model/order_model.dart';

abstract class UserOrderStates {}

class InitialUserOrderState extends UserOrderStates {}

class LoadingGetUserOrderState extends UserOrderStates {}

class SuccessGetUserOrderState extends UserOrderStates {
  final List<OrderModel> list;
  SuccessGetUserOrderState(this.list);
}

class ErrorGetUserOrderState extends UserOrderStates {
  final String message;
  ErrorGetUserOrderState(this.message);
}
