class SupplementData {
  final List<String> images;
  final String description;
  final String title;
  final String id;

  SupplementData({
    required this.images,
    required this.description,
    required this.title,
    required this.id,
  });

  factory SupplementData.fromJson(Map<String, dynamic> json) {
    return SupplementData(
      images: List<String>.from(json['images']),
      description: json['description'] ?? '',
      title: json['title'] ?? '',
      id: json['id'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['images'] = images;
    data['description'] = description;
    data['title'] = title;
    data['id'] = id;
    return data;
  }
}
