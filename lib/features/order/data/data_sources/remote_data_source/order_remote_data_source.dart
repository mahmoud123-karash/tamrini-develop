import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/features/order/data/models/order_model/order_model.dart';

abstract class OrderRemoteDataSource {
  Future<List<OrderModel>> get();
}

class OrderRemoteDataSourceImpl extends OrderRemoteDataSource {
  @override
  Future<List<OrderModel>> get() async {
    String uid = CacheHelper.getData(key: 'uid');

    List<OrderModel> list = [];
    var result = await FirebaseFirestore.instance
        .collection('stores')
        .doc(uid)
        .collection('orders')
        .get();

    for (var element in result.docs) {
      OrderModel model = OrderModel.fromJson(element.data());
      list.add(model);
    }
    return list;
  }
}
