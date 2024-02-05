import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/home_exercise/presentation/manager/home_exercise_cubit/home_exercise_cubit.dart';
import 'package:tamrini/features/home_exercise/presentation/manager/home_exercise_cubit/home_exercise_states.dart';

class HomeExerciseCustomButtonBuilderWidget extends StatelessWidget {
  const HomeExerciseCustomButtonBuilderWidget(
      {super.key, required this.onPressed, required this.lable});
  final VoidCallback onPressed;
  final String lable;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeExerciseCubit, HomeExersiceStates>(
      listener: (context, state) {
        if (state is ErrorGetHomeExerciseState) {
          showSnackBar(context, state.message);
          HomeExerciseCubit.get(context).getData();
        }
      },
      builder: (context, state) {
        if (state is LoadingGetHomeExerciseState) {
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
