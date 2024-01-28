import 'package:tamrini/features/trainer/data/models/trainer_model/rating_model.dart';

class ProductModel {
  final String title;
  final String description;
  final String id;
  final num price;
  final num oldPrice;
  final String image;
  final String type;
  final String ownerUid;
  final String contact;
  final bool available;
  final bool bestSeller;

  List<Rating> rating;

  ProductModel({
    required this.contact,
    required this.ownerUid,
    required this.title,
    required this.description,
    required this.id,
    required this.type,
    required this.image,
    required this.price,
    required this.oldPrice,
    required this.available,
    required this.bestSeller,
    required this.rating,
  });

  Map<String, dynamic> toMap() {
    return {
      'description': description,
      'title': title,
      'id': id,
      'contact': contact,
      'image': image,
      'price': price,
      'ownerUid': ownerUid,
      'available': available,
      'bestSeller': bestSeller,
      'type': type,
      'oldPrice': oldPrice,
      'rating': rating,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    final List<dynamic> productsJson = map['rating'] ?? [];
    List<Rating> rate = productsJson.map((productJson) {
      return Rating.fromJson(productJson);
    }).toList();
    return ProductModel(
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      id: map['id'] ?? '',
      contact: map['contact'] ?? '',
      ownerUid: map['ownerUid'] ?? '',
      oldPrice: map['oldPrice'] ?? '',
      image: map['image'] ?? '',
      price: map['price'] ?? 0,
      available: map['available'] ?? false,
      bestSeller: map['bestSeller'] ?? false,
      type: map['type'] ?? '',
      rating: rate,
    );
  }
}
