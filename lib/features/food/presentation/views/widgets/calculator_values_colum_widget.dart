import 'package:flutter/material.dart';
import 'package:tamrini/features/food/presentation/manager/calculator_cubit.dart/calculator_cubit.dart';
import 'package:tamrini/features/food/presentation/views/widgets/nurition_value_lable_widget.dart';
import 'package:tamrini/generated/l10n.dart';

class CalculatorValuesColumWidget extends StatelessWidget {
  const CalculatorValuesColumWidget({super.key, required this.cubit});
  final CalculatorCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          NutritionValueLableWidget(
            lable: S.of(context).calories,
            value: cubit.calories,
          ),
          NutritionValueLableWidget(
            lable: S.of(context).protien,
            value: cubit.protein,
          ),
          NutritionValueLableWidget(
            lable: S.of(context).fat,
            value: cubit.fat,
          ),
          NutritionValueLableWidget(
            lable: S.of(context).carb,
            value: cubit.carbs,
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
