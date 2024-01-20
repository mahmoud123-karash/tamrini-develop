class CalculatorModel {
  final double calories;
  final double protein;
  final double fat;
  final double carbs;

  CalculatorModel({
    required this.calories,
    required this.protein,
    required this.fat,
    required this.carbs,
  });

  factory CalculatorModel.fromJson(Map<String, dynamic> json) =>
      CalculatorModel(
        calories: json['calories'] ?? 0.0,
        protein: json['protein'] ?? 0.0,
        fat: json['fat'] ?? 0.0,
        carbs: json['carbs'] ?? 0.0,
      );

  Map<String, dynamic> toJson() => {
        "calories": calories,
        "fat": fat,
        "protein": protein,
        "carbs": carbs,
      };
}
