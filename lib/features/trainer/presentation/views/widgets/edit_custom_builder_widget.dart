import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/trainer/presentation/manager/trainer_cubit/trainers_cubit.dart';
import 'package:tamrini/features/trainer/presentation/manager/trainer_cubit/trainers_states.dart';
import 'package:tamrini/generated/l10n.dart';

class EditCustomBuilderWidget extends StatelessWidget {
  const EditCustomBuilderWidget({super.key, required this.onPressed});
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TrainersCubit, TrainersStates>(
      listener: (context, state) {
        if (state is SucessGetTrainersState) {
          Navigator.pop(context);
          showSnackBar(context, S.of(context).success_edit_a);
        }
        if (state is ErrorGetTrainersState) {
          showSnackBar(context, state.message);
          TrainersCubit.get(context).getData();
        }
      },
      builder: (context, state) {
        if (state is LoadingGetTrainersState) {
          return const CircularProgressIndicator();
        } else {
          return customButton(
            onPressed: onPressed,
            lable: S.of(context).edit,
          );
        }
      },
    );
  }
}
