import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/food/presentation/views/widgets/add_meal_to_myday_custom_button_widget.dart';
import 'package:tamrini/features/my_day/presentation/manager/day_cubit/day_cubit.dart';
import 'package:tamrini/features/my_day/presentation/manager/day_cubit/day_states.dart';
import 'package:tamrini/generated/l10n.dart';

class AddMealCustomButtonBuilderWidget extends StatelessWidget {
  const AddMealCustomButtonBuilderWidget({
    super.key,
    required this.calories,
    required this.protein,
    required this.fat,
    required this.carbs,
    required this.id,
    required this.grams,
    required this.name,
  });
  final num calories, protein, fat, carbs, grams;
  final String id, name;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DayCubit, DayStates>(
      listener: (context, state) {
        if (state is SucessGetDayState) {
          showSnackBar(context, S.of(context).success_add_meal);
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
          return AddMealToMaydaycustomButtonWidget(
            calories: calories,
            protein: protein,
            fat: fat,
            carbs: carbs,
            grams: grams,
            id: id,
            name: name,
          );
        }
      },
    );
  }
}
