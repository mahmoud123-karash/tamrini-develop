import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/diet_food/presentation/manager/diet_food_cubit/diet_food_cubit.dart';
import 'package:tamrini/features/diet_food/presentation/manager/diet_food_cubit/diet_food_states.dart';

class FoodCustombuilderWidget extends StatelessWidget {
  const FoodCustombuilderWidget(
      {super.key, required this.onPressed, required this.lable});
  final VoidCallback onPressed;
  final String lable;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DietFoodCubit, DietFoodStates>(
      listener: (context, state) {
        if (state is ErrorGetDietFoodState) {
          showSnackBar(context, state.message);
          DietFoodCubit.get(context).getData();
        }
      },
      builder: (context, state) {
        if (state is LoadingGetDietFoodState) {
          return const Padding(
            padding: EdgeInsets.all(15.0),
            child: CircularProgressIndicator(),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            child: customButton(
              onPressed: onPressed,
              lable: lable,
            ),
          );
        }
      },
    );
  }
}
