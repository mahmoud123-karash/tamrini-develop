import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:tamrini/core/api/dio_helper.dart';
import 'package:tamrini/core/cache/shared_preference.dart';
import 'package:tamrini/core/models/notification_model/notification_model.dart';
import 'package:tamrini/features/order/data/data_sources/remote_data_source/order_remote_data_source.dart';
import 'package:tamrini/features/order/data/models/order_model/order_model.dart';
import 'package:tamrini/features/order/data/models/order_model/product.dart';
import 'package:tamrini/features/order/domain/repo/order_repo.dart';
import 'package:uuid/uuid.dart';

class OrederRepoImpl extends OrderRepo {
  final OrderRemoteDataSource orderRemoteDataSource;
  final DioHelper dioHelper;

  OrederRepoImpl(this.orderRemoteDataSource, this.dioHelper);

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
        status: 'Pending',
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

  @override
  Future<Either<String, List<OrderModel>>> updateOrder({
    required String status,
    required String orderId,
  }) async {
    try {
      await FirebaseFirestore.instance.collection('orders').doc(orderId).update(
        {"status": status},
      );
      List<OrderModel> list = await orderRemoteDataSource.getStoreOrders();
      return right(list);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, List<OrderModel>>> userReciededOrder({
    required String status,
    required String orderId,
    required String stroreId,
    required num totalPrice,
  }) async {
    try {
      await FirebaseFirestore.instance.collection('orders').doc(orderId).update(
        {
          "status": status,
        },
      );

      await updateStoreProfits(stroreId, totalPrice);
      await sendNotification(owneruid: stroreId, orderUid: orderId);
      List<OrderModel> list = await orderRemoteDataSource.getUserOrders();
      return right(list);
    } catch (e) {
      return left(e.toString());
    }
  }

  Future<void> updateStoreProfits(String stroreId, num totalPrice) async {
    var data = await FirebaseFirestore.instance
        .collection('stores')
        .doc(stroreId)
        .get();
    num profits = data['profits'] ?? 0;
    await FirebaseFirestore.instance.collection('stores').doc(stroreId).update({
      "profits": profits + totalPrice,
    });
  }

  Future<void> sendNotification({
    required String owneruid,
    required String orderUid,
  }) async {
    String uid = CacheHelper.getData(key: 'uid');

    NotificationModel notification = NotificationModel(
      isReaden: false,
      subType: 'order',
      senderUid: uid,
      title: 'order',
      body: '',
      type: 'notification',
      uid: orderUid,
      time: Timestamp.now(),
    );
    await FirebaseFirestore.instance
        .collection('notification')
        .doc(owneruid)
        .collection('data')
        .add(
          notification.toJson(),
        );
    var data = await FirebaseFirestore.instance
        .collection('users')
        .doc(owneruid)
        .get();
    String token = data['token'] ?? '';
    if (token != '') {
      dioHelper.sendNotification(
        token: token,
        title: 'المتجر',
        body: 'تم استلام الطلب واضافت الأرباح ',
        data: {
          "type": "notification",
          "subType": "order",
          "uid": orderUid,
        },
      );
    }
  }
}
