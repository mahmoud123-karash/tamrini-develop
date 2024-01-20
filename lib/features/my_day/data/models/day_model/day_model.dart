import 'package:tamrini/features/my_day/data/models/day_model/calculator_model.dart';

import 'nutrient.dart';

class DayModel {
  final CalculatorModel model;
  Map<String, Nutrient> nutrients;

  DayModel({required this.model, required this.nutrients});

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
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> nutrientsJson = nutrients.map((key, value) {
      return MapEntry(key, value.toJson());
    });

    return {
      'nutrients': nutrientsJson,
      'ks': model.toJson(),
    };
  }
}
