import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/my_day/data/models/day_model/day_model.dart';
import 'package:tamrini/features/my_day/presentation/views/widgets/day_protien_calculator_widget.dart';
import 'package:tamrini/generated/l10n.dart';

import 'widgets/day_add_meal_widget.dart';
import 'widgets/day_meals_container_widget.dart';

class DayScreen extends StatelessWidget {
  const DayScreen({super.key, required this.model});
  final DayModel model;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(
        DateFormat('EEEE, MMM d, yyyy').format(
          model.date.toDate(),
        ),
      ),
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
                model: model.model,
              ),
              const SizedBox(
                height: 15,
              ),
              DayProtienCalculatorWidget(
                name: S.of(context).your_need,
                model: model.model,
              ),
              const SizedBox(
                height: 15,
              ),
              DayMealsContainerWidget(map: model.nutrients),
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
