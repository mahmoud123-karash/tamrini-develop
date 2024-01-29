import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tamrini/features/order/data/models/order_model/product.dart';

class OrderModel {
  final String user;
  final String address;
  final Product product;
  final String status;
  final Timestamp createdAt;
  final String id;
  final String paymentMethod;

  OrderModel({
    required this.address,
    required this.user,
    required this.product,
    required this.status,
    required this.createdAt,
    required this.id,
    required this.paymentMethod,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        address: json['address'] ?? '',
        user: json['user'] ?? '',
        product: Product.fromJson(json['product']),
        status: json['status'] ?? '',
        createdAt: json['createdAt'] ?? Timestamp.now(),
        id: json['id'] ?? '',
        paymentMethod: json['paymentMethod'] ?? '',
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['address'] = address;
    data['user'] = user;
    data['product'] = product.toJson();
    data['status'] = status;
    data['createdAt'] = createdAt;
    data['paymentMethod'] = paymentMethod;
    return data;
  }
}
