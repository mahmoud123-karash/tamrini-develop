class Product {
  String? image;
  List<Data>? data;
  String? title;
  String? id;

  Product({this.image, this.data, this.title, required this.id});

  Product.fromJson(Map<String, dynamic> json, String id) {
    image = json['image'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }

    title = json['title'];
    this.id = id;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image'] = image;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['title'] = title;
    return data;
  }
}

class Data {
  List<String>? assets;
  int? price;
  String? description;
  String? title;
  String? id;
  bool? available;

  Data(
      {this.assets,
      this.price,
      this.description,
      this.title,
      this.available,
      required this.id});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['image'] != null) {
      assets = <String>[];
      json['image'].forEach((v) {
        assets!.add(v);
      });
    }
    price = json['price'];
    description = json['description'];
    title = json['title'];
    available = json['available'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image'] = assets;
    data['price'] = price;
    data['description'] = description;
    data['title'] = title;
    data['avilable'] = available;
    data['id'] = id;
    return data;
  }
}
