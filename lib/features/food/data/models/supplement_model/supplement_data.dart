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
      images: json['images'] ?? [],
      description: json['description'] ?? '',
      title: json['title'] ?? '',
      id: json['id'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> Supplementdata = <String, dynamic>{};
    Supplementdata['images'] = images;
    Supplementdata['description'] = description;
    Supplementdata['title'] = title;
    Supplementdata['id'] = id;
    return Supplementdata;
  }
}
