import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/my_day/presentation/manager/day_cubit/day_cubit.dart';
import 'package:tamrini/features/my_day/presentation/manager/day_cubit/day_states.dart';
import 'package:tamrini/generated/l10n.dart';

import 'my_day_recalculator_widget.dart';

class MyDayRecalculateBuilderWidget extends StatelessWidget {
  const MyDayRecalculateBuilderWidget(
      {super.key,
      required this.calories,
      required this.protein,
      required this.fat,
      required this.carbs,
      required this.id});
  final num calories, protein, fat, carbs;
  final String id;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DayCubit, DayStates>(
      listener: (context, state) {
        if (state is SucessGetDayState) {
          showSnackBar(context, S.of(context).success_recalulate);
          Navigator.pop(context);
        }
        if (state is ErrorGetDayState) {
          showSnackBar(context, state.message);
        }
      },
      builder: (context, state) {
        if (state is LoadingGetDayState) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          return MydayRecalculatorWidget(
            calories: calories,
            protein: protein,
            fat: fat,
            carbs: carbs,
            id: id,
          );
        }
      },
    );
  }
}
