import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/features/order/data/data_sources/remote_data_source/order_remote_data_source.dart';
import 'package:tamrini/features/order/data/models/order_model/order_model.dart';
import 'package:tamrini/features/order/data/models/order_model/product.dart';
import 'package:tamrini/features/order/domain/repo/order_repo.dart';
import 'package:uuid/uuid.dart';

class OrederRepoImpl extends OrderRepo {
  final OrderRemoteDataSource orderRemoteDataSource;

  OrederRepoImpl(this.orderRemoteDataSource);

  @override
  Future<Either<String, List<OrderModel>>> getUserOrders() async {
    try {
      List<OrderModel> list = await orderRemoteDataSource.getUserOrders();
      return right(list);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, List<OrderModel>>> getStoreOrders() async {
    try {
      List<OrderModel> list = await orderRemoteDataSource.getStoreOrders();
      return right(list);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, List<OrderModel>>> makeOrder({
    required String address,
    required String storeId,
    required String name,
    required String phone,
    required Product product,
  }) async {
    try {
      String uid = CacheHelper.getData(key: 'uid');
      var uuid = const Uuid().v4();
      OrderModel order = OrderModel(
        userPhone: phone,
        userName: name,
        address: address,
        userId: uid,
        product: product,
        status: 'waiting',
        createdAt: Timestamp.now(),
        orderId: uuid,
        storeId: storeId,
        paymentMethod: 'Zain cash',
      );
      await FirebaseFirestore.instance.collection('orders').doc(uuid).set(
            order.toJson(),
          );
      List<OrderModel> list = await orderRemoteDataSource.getUserOrders();
      return right(list);
    } catch (e) {
      return left(e.toString());
    }
  }
}
