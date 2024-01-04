import 'package:tamrini/features/home/data/models/store_model/product_model.dart';

class StoreModel {
  final String name;
  final String contact;
  final String image;
  final String storeOwnerUid;

  List<ProductModel>? products;

  StoreModel({
    required this.image,
    required this.name,
    required this.storeOwnerUid,
    required this.contact,
    required this.products,
  });

  factory StoreModel.fromMap(Map<String, dynamic> map) {
    final List<dynamic> productsJson = map['products'];
    List<ProductModel> products = productsJson.map((productJson) {
      return ProductModel.fromMap(productJson);
    }).toList();

    return StoreModel(
      name: map['name'] ?? '',
      image: map['image'] ?? '',
      storeOwnerUid: map['storeOwnerUid'] ?? '',
      contact: map['contact'] ?? '',
      products: products,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'storeOwnerUid': storeOwnerUid,
      'name': name,
      'image': image,
      'contact': contact,
      'products': products,
    };
  }
}
