import 'package:dartz/dartz.dart';
import 'package:tamrini/features/order/data/models/order_model/order_model.dart';
import 'package:tamrini/features/order/data/models/order_model/product.dart';

abstract class OrderRepo {
  Future<Either<String, List<OrderModel>>> getStoreOrders();
  Future<Either<String, List<OrderModel>>> getUserOrders();
  Future<Either<String, List<OrderModel>>> makeOrder({
    required String address,
    required String storeId,
    required String name,
    required String phone,
    required Product product,
  });

  Future<Either<String, List<OrderModel>>> updateOrder({
    required String status,
    required String orderId,
  });

  Future<Either<String, List<OrderModel>>> userReciededOrder({
    required String status,
    required String orderId,
    required String stroreId,
    required num totalPrice,
  });
}
