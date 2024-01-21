import 'package:dartz/dartz.dart';
import 'package:tamrini/features/my_day/data/models/day_model/calculator_model.dart';
import 'package:tamrini/features/my_day/data/models/day_model/day_model.dart';
import 'package:tamrini/features/my_day/data/models/day_model/nutrient.dart';

abstract class MyDayRepo {
  Future<Either<String, List<DayModel>>> getData();
  Future<Either<String, List<DayModel>>> addToday();
  Future<Either<String, List<DayModel>>> reCalculate({
    required DayModel model,
    required CalculatorModel calculatorModel,
  });
  Future<Either<String, List<DayModel>>> addMealToDay({
    required DayModel model,
    required Nutrient nutrient,
    required String name,
  });
  Future<Either<String, List<DayModel>>> removeMealFromDay({
    required DayModel model,
    required String name,
  });
}
