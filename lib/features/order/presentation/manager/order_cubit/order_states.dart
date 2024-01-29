import 'package:tamrini/features/order/data/models/order_model/order_model.dart';

abstract class OrderStates {}

class InitialOrderState extends OrderStates {}

class LoadinGetOrdersState extends OrderStates {}

class SuccessGetOrdersState extends OrderStates {
  final List<OrderModel> list;
  SuccessGetOrdersState(this.list);
}

class ErrorGetOrdersState extends OrderStates {
  final String message;
  ErrorGetOrdersState(this.message);
}
