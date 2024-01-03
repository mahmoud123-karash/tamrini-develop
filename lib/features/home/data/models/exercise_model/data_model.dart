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
    assets = json['image'].cast<String>();
    description = json['description'];
    title = json['title'];
    id = json['id'];
  }
}
