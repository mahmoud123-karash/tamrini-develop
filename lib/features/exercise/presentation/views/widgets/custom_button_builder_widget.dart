import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/exercise/presentation/manager/exercise_cubit/exercise_cubit.dart';
import 'package:tamrini/features/exercise/presentation/manager/exercise_cubit/exercise_states.dart';

class CustomButtonBuilderWidget extends StatelessWidget {
  const CustomButtonBuilderWidget(
      {super.key, required this.onPressed, required this.lable});
  final VoidCallback onPressed;
  final String lable;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ExerciseCubit, ExerciseStates>(
      listener: (context, state) {
        if (state is ErrorGetExerciseState) {
          showSnackBar(context, state.message);
        }
        if (state is SucessGetExerciseState) {
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        if (state is LoadingGetExerciseState) {
          return const Padding(
            padding: EdgeInsets.all(8.0),
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
