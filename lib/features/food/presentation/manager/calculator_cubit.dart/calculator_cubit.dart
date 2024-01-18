import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/features/food/presentation/manager/calculator_cubit.dart/calculator_states.dart';
import 'package:tamrini/generated/l10n.dart';

enum Target { purpose, increaseWeight, loseWeight, maintainWeight }

enum ActivityLevel { light, moderate, very, extra }

enum Gender { m, f }

class CalculatorCubit extends Cubit<CalculatorStates> {
  CalculatorCubit() : super(InitialCalculatorState());

  static CalculatorCubit get(context) => BlocProvider.of(context);
  int selectedPurpose = 0;
  int selectedActivity = 0;

  double protein = 0.0;
  double fat = 0.0;
  double carbs = 0.0;
  double calories = 0.0;

  List<String> names(context) => [
        S.of(context).exercise_purpose,
        S.of(context).weight_gain,
        S.of(context).weight_loss,
        S.of(context).weight_maintenance,
      ];

  List<String> activities(context) => [
        S.of(context).low_activity,
        S.of(context).moderate_activity,
        S.of(context).high_activity,
        S.of(context).very_intense_activity,
      ];

  Target target = Target.purpose;
  ActivityLevel activityLevel = ActivityLevel.light;
  Gender selectedGender = Gender.m;
  int height = 180;
  int wight = 70;
  int age = 25;

  void calculate() {
    calories = Gender.m == selectedGender
        ? (10 * wight + 6.25 * height - 5 * age + 5)
        : (10 * wight + 6.25 * height - 5 * age - 161);

    switch (activityLevel) {
      case ActivityLevel.light:
        calories = (1.1 * calories);
        break;
      case ActivityLevel.moderate:
        calories = (1.3 * calories);
        break;
      case ActivityLevel.very:
        calories = (1.5 * calories);
        break;
      case ActivityLevel.extra:
        calories = (1.7 * calories);
        break;
    }

    switch (target) {
      case Target.loseWeight:
        if (calories <= 2000) {
          calories = (0.9 * calories);
        } else {
          calories = (0.8 * calories);
        }
        protein = (0.4 * calories / 4);
        carbs = (0.4 * calories / 4);
        fat = (0.2 * calories / 9);
        break;
      case Target.maintainWeight:
        protein = (0.3 * calories / 4);
        carbs = (0.45 * calories / 4);
        fat = (0.25 * calories / 9);
        break;
      case Target.increaseWeight:
        calories += 500;
        protein = (0.3 * calories / 4);
        carbs = (0.45 * calories / 4);
        fat = (0.25 * calories / 9);
        break;
      case Target.purpose:
        break;
    }
    emit(SuccessCalculateState());
  }

  reset() {
    protein = 0.0;
    fat = 0.0;
    carbs = 0.0;
    calories = 0.0;
    emit(SuccessResetState());
  }
}
