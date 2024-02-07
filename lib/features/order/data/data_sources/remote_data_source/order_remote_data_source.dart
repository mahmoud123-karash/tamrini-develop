import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/features/order/data/models/order_model/order_model.dart';

abstract class OrderRemoteDataSource {
  Future<List<OrderModel>> getStoreOrders();
  Future<List<OrderModel>> getUserOrders();
}

class OrderRemoteDataSourceImpl extends OrderRemoteDataSource {
  @override
  Future<List<OrderModel>> getStoreOrders() async {
    String uid = CacheHelper.getData(key: 'uid');
    List<OrderModel> list = [];
    var result = await FirebaseFirestore.instance
        .collection('orders')
        .where('storeId', isEqualTo: uid)
        .orderBy(
          'createdAt',
          descending: true,
        )
        .get();

    for (var element in result.docs) {
      OrderModel model = OrderModel.fromJson(element.data());
      list.add(model);
    }
    return list;
  }

  @override
  Future<List<OrderModel>> getUserOrders() async {
    String uid = CacheHelper.getData(key: 'uid');
    List<OrderModel> list = [];
    var result = await FirebaseFirestore.instance
        .collection('orders')
        .where('userId', isEqualTo: uid)
        .orderBy(
          'createdAt',
          descending: true,
        )
        .get();

    for (var element in result.docs) {
      OrderModel model = OrderModel.fromJson(element.data());
      list.add(model);
    }
    return list;
  }
}
