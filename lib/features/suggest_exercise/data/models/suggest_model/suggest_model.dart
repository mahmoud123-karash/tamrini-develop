class SuggestModel {
  final String id;
  final String title;
  final String url;
  final String image;

  SuggestModel(
      {required this.id,
      required this.title,
      required this.url,
      required this.image});

  factory SuggestModel.fromJson(Map<String, dynamic> json) => SuggestModel(
        id: json['id'] ?? '',
        title: json['title'] ?? '',
        url: json['url'] ?? '',
        image: json['image'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "url": url,
        "image": image,
      };
}
