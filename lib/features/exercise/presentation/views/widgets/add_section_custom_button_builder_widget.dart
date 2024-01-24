import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/exercise/presentation/manager/exercise_cubit/exercise_cubit.dart';
import 'package:tamrini/features/exercise/presentation/manager/exercise_cubit/exercise_states.dart';
import 'package:tamrini/generated/l10n.dart';

class AddSectionCustomButtonBuilderWidget extends StatelessWidget {
  const AddSectionCustomButtonBuilderWidget(
      {super.key, required this.onPressed, required this.isEdit});
  final VoidCallback onPressed;
  final bool isEdit;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ExerciseCubit, ExerciseStates>(
      listener: (context, state) {
        if (state is ErrorGetExerciseState) {
          showSnackBar(context, state.message);
        }
        if (state is SucessGetExerciseState) {
          Navigator.pop(context);
          showSnackBar(context, S.of(context).success_add_e);
        }
      },
      builder: (context, state) {
        if (state is LoadingGetExerciseState) {
          return const Padding(
            padding: EdgeInsets.all(8.0),
            child: CircularProgressIndicator(),
          );
        } else {
          return customButton(
            onPressed: onPressed,
            lable:
                isEdit ? S.of(context).edit_section : S.of(context).add_section,
          );
        }
      },
    );
  }
}
