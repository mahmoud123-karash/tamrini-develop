import 'package:flutter/material.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/my_day/presentation/views/widgets/day_add_meal_widget.dart';
import 'package:tamrini/features/my_day/presentation/views/widgets/day_protien_calculator_widget.dart';
import 'package:tamrini/generated/l10n.dart';

import 'widgets/day_meals_container_widget.dart';

class MyDayScreen extends StatelessWidget {
  const MyDayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(S.of(context).my_day),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              const DayAddMealWidget(),
              const SizedBox(
                height: 10,
              ),
              DayProtienCalculatorWidget(
                name: S.of(context).protein_calculator,
                isCalculator: true,
              ),
              const SizedBox(
                height: 15,
              ),
              DayProtienCalculatorWidget(
                name: S.of(context).your_need,
              ),
              const SizedBox(
                height: 15,
              ),
              const DayMealsContainerWidget(),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
