class CategoryModel {
  final String id;
  final String title;
  final String image;

  CategoryModel({
    required this.id,
    required this.title,
    required this.image,
  });

  factory CategoryModel.formJson(Map<String, dynamic> json, id) =>
      CategoryModel(
        id: id,
        title: json['title'] ?? '',
        image: json['image'] ?? '',
      );
}
