class Nutrient {
  num carbs;
  num protein;
  num fat;
  num calories;
  num grams;

  Nutrient({
    required this.carbs,
    required this.protein,
    required this.fat,
    required this.calories,
    required this.grams,
  });

  factory Nutrient.fromJson(Map<String, dynamic> json) {
    return Nutrient(
      carbs: json['carbs'] ?? 0.0,
      protein: json['protein'] ?? 0.0,
      fat: json['fat'] ?? 0.0,
      calories: json['calories'] ?? 0.0,
      grams: json['grams'] ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'carbs': carbs,
      'protein': protein,
      'fat': fat,
      'calories': calories,
      'grams': grams,
    };
  }
}
