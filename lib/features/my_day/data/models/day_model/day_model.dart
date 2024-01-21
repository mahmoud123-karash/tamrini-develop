import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import 'package:tamrini/features/my_day/data/models/day_model/calculator_model.dart';

import 'nutrient.dart';

part 'day_model.g.dart';

@HiveType(typeId: 2)
class DayModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final Timestamp date;
  @HiveField(2)
  final CalculatorModel model;
  @HiveField(3)
  Map<String, Nutrient> nutrients;

  DayModel({
    required this.model,
    required this.nutrients,
    required this.id,
    required this.date,
  });

  factory DayModel.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> nutrientsJson = json['nutrients'] ?? {};
    Map<String, Nutrient> nutrients = nutrientsJson.map((key, value) {
      return MapEntry(key, Nutrient.fromJson(value));
    });

    Map<String, dynamic> calculatorJson = json['proteins_calc'] ?? {};

    return DayModel(
      nutrients: nutrients,
      model: CalculatorModel.fromJson(
        calculatorJson,
      ),
      id: json['id'] ?? '',
      date: json['date'] ?? Timestamp.now(),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> nutrientsJson = nutrients.map((key, value) {
      return MapEntry(key, value.toJson());
    });

    return {
      'nutrients': nutrientsJson,
      'proteins_calc': model.toJson(),
      'date': date,
      'id': id,
    };
  }
}
