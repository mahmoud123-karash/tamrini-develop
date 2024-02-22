import 'package:hive/hive.dart';
part 'meal_model.g.dart';

@HiveType(typeId: 7)
class MealModel {
  @HiveField(0)
  final num carbs;
  @HiveField(1)
  final num protein;
  @HiveField(2)
  final num fat;
  @HiveField(3)
  final num calories;
  @HiveField(4)
  final String id;
  @HiveField(5)
  final String name;
  @HiveField(6)
  final num wieght;

  MealModel({
    required this.carbs,
    required this.protein,
    required this.fat,
    required this.calories,
    required this.id,
    required this.name,
    required this.wieght,
  });

  factory MealModel.fromJson(Map<String, dynamic> json) {
    return MealModel(
      carbs: json['carbs'] ?? 0.0,
      protein: json['protein'] ?? 0.0,
      fat: json['fat'] ?? 0.0,
      calories: json['calories'] ?? 0.0,
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      wieght: json['wieght'] ?? 50,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'carbs': carbs,
      'protein': protein,
      'fat': fat,
      'calories': calories,
      'id': id,
      'name': name,
      'wieght': wieght,
    };
  }
}
