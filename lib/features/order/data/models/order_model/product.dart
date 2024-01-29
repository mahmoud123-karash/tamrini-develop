class Product {
  final String title;
  final String image;
  final String id;
  final int price;
  final int quantity;

  Product({
    required this.title,
    required this.image,
    required this.id,
    required this.price,
    required this.quantity,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        title: json['title'] ?? '',
        image: json['image'] ?? '',
        id: json['id'] ?? '',
        price: json['price'] ?? 0,
        quantity: json['quantity'] ?? 0,
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['price'] = price;
    data['id'] = id;
    data['image'] = image;
    data['quantity'] = quantity;
    return data;
  }
}
