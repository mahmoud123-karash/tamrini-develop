class ClassificationModel {
  final String classification;
  final String id;

  ClassificationModel({
    required this.classification,
    required this.id,
  });

  factory ClassificationModel.fromJson(Map<String, dynamic> json) {
    return ClassificationModel(
      classification: json['classification'] ?? '',
      id: json['id'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'classification': classification,
        'id': id,
      };
}
