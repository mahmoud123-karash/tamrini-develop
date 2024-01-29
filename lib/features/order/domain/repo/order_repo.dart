import 'package:dartz/dartz.dart';
import 'package:tamrini/features/order/data/models/order_model/order_model.dart';

abstract class OrderRepo {
  Future<Either<String, List<OrderModel>>> getOrders();
}
