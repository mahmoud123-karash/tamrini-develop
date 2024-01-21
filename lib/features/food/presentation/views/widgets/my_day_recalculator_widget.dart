import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/features/my_day/data/models/day_model/calculator_model.dart';
import 'package:tamrini/features/my_day/presentation/manager/day_cubit/day_cubit.dart';
import 'package:tamrini/generated/l10n.dart';

class MydayRecalculatorWidget extends StatelessWidget {
  const MydayRecalculatorWidget({
    super.key,
    required this.calories,
    required this.protein,
    required this.fat,
    required this.carbs,
    required this.id,
  });
  final num calories, protein, fat, carbs;
  final String id;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 10,
      ),
      child: MaterialButton(
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        color: appColor,
        onPressed: () {
          DayCubit.get(context).recalulate(
            calculatorModel: CalculatorModel(
              calories: calories,
              protein: protein,
              fat: fat,
              carbs: carbs,
            ),
            id: id,
          );
        },
        child: Center(
          child: Text(
            S.of(context).recalculate,
            style: TextStyles.style17.copyWith(
              color: whiteColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
