import 'package:hive/hive.dart';
part 'calculator_model.g.dart';

@HiveType(typeId: 3)
class CalculatorModel {
  @HiveField(0)
  final num calories;
  @HiveField(1)
  final num protein;
  @HiveField(2)
  final num fat;
  @HiveField(3)
  final num carbs;

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
