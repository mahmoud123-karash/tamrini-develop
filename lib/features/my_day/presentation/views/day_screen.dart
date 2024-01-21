import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/my_day/data/models/day_model/calculator_model.dart';
import 'package:tamrini/features/my_day/data/models/day_model/day_model.dart';
import 'package:tamrini/features/my_day/presentation/manager/day_cubit/day_cubit.dart';
import 'package:tamrini/features/my_day/presentation/views/widgets/day_protien_calculator_widget.dart';
import 'package:tamrini/generated/l10n.dart';

import '../manager/day_cubit/day_states.dart';
import 'widgets/day_add_meal_widget.dart';
import 'widgets/day_meals_container_widget.dart';

class DayScreen extends StatelessWidget {
  const DayScreen({super.key, required this.id, required this.date});
  final String id;
  final Timestamp date;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(
        DateFormat('EEEE, MMM d, yyyy').format(
          date.toDate(),
        ),
      ),
      body: BlocBuilder<DayCubit, DayStates>(
        builder: (context, state) {
          DayModel model = DayCubit.get(context).getDay(id: id);
          CalculatorModel calculatorModel =
              DayCubit.get(context).getNeeds(id: id);

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  DayAddMealWidget(id: model.id),
                  const SizedBox(
                    height: 10,
                  ),
                  DayProtienCalculatorWidget(
                    name: S.of(context).protein_calculator,
                    isCalculator: true,
                    model: model.model,
                    id: model.id,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                    onTap: () {
                      log(calculatorModel.calories.toString());
                    },
                    child: DayProtienCalculatorWidget(
                      name: S.of(context).your_need,
                      model: calculatorModel,
                      id: '',
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  DayMealsContainerWidget(map: model.nutrients, id: id),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
