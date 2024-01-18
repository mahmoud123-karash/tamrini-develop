class NutritionModel {
  final String title;
  final double calories;
  final double proteins;
  final double fats;
  final double carbs;
  String? id;

  NutritionModel({
    required this.title,
    required this.calories,
    required this.proteins,
    required this.fats,
    required this.carbs,
    String? id,
  });

  factory NutritionModel.fromJson(Map<String, dynamic> json, id) {
    return NutritionModel(
      title: json['title'] ?? '',
      calories: json['calories'] ?? 0.0,
      proteins: json['proteins'] ?? 0.0,
      fats: json['fats'] ?? 0.0,
      carbs: json['carbs'] ?? 0.0,
      id: id,
    );
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'calories': calories,
        'proteins': proteins,
        'fats': fats,
        'carbs': carbs,
      };
}
