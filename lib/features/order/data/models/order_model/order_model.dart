import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tamrini/features/order/data/models/order_model/product.dart';

class OrderModel {
  final String userId;
  final String userName;
  final String userPhone;
  final String address;
  final Product product;
  final String status;
  final Timestamp createdAt;
  final String orderId;
  final String storeId;
  final String paymentMethod;

  OrderModel({
    required this.address,
    required this.userId,
    required this.userName,
    required this.userPhone,
    required this.product,
    required this.status,
    required this.createdAt,
    required this.orderId,
    required this.storeId,
    required this.paymentMethod,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        address: json['address'] ?? '',
        userId: json['userId'] ?? '',
        product: Product.fromJson(json['product']),
        status: json['status'] ?? '',
        createdAt: json['createdAt'] ?? Timestamp.now(),
        orderId: json['orderId'] ?? '',
        paymentMethod: json['paymentMethod'] ?? '',
        storeId: json['storeId'] ?? '',
        userName: json['userName'] ?? '',
        userPhone: json['userPhone'] ?? '',
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['address'] = address;
    data['userId'] = userId;
    data['product'] = product.toJson();
    data['status'] = status;
    data['createdAt'] = createdAt;
    data['paymentMethod'] = paymentMethod;
    data['storeId'] = storeId;
    data['userName'] = userName;
    data['orderId'] = orderId;
    data['userPhone'] = userPhone;
    return data;
  }
}
