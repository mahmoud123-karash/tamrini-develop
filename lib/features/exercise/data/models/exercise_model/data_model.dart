class DataModel {
  List<String>? assets;
  String? description;
  String? title;
  String? id;

  DataModel({
    this.assets,
    this.description,
    this.title,
    required this.id,
  });

  DataModel.fromJson(Map<String, dynamic> json) {
    assets = List<String>.from(json['image'] ?? []);
    description = json['description'];
    title = json['title'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    return {
      'image': assets,
      'description': description,
      'title': title,
      'id': id,
    };
  }
}
