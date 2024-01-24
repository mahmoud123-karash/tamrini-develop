import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/auth/presentation/manager/reset_cubit/reset_states.dart';
import 'package:tamrini/features/home/presentation/manager/exercise_cubit/exercise_cubit.dart';
import 'package:tamrini/features/home/presentation/manager/exercise_cubit/exercise_states.dart';
import 'package:tamrini/generated/l10n.dart';

class AddSectionCustomButtonBuilderWidget extends StatelessWidget {
  const AddSectionCustomButtonBuilderWidget(
      {super.key, required this.onPressed});
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ExerciseCubit, ExerciseStates>(
      listener: (context, state) {
        if (state is ErrorGetExerciseState) {
          showSnackBar(context, state.message);
        }
        if (state is SuccessResetState) {
          Navigator.pop(context);
          showSnackBar(context, S.of(context).success_add_e);
        }
      },
      builder: (context, state) {
        if (state is LoadingGetExerciseState) {
          return const CircularProgressIndicator();
        } else {
          return customButton(
            onPressed: onPressed,
            lable: S.of(context).add_section,
          );
        }
      },
    );
  }
}
