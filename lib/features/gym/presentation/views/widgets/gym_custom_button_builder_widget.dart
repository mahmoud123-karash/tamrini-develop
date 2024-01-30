import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/gym/presentation/manager/gym_cubit/gym_cubit.dart';
import 'package:tamrini/features/gym/presentation/manager/gym_cubit/gym_states.dart';

class GymCustombuilderWidget extends StatelessWidget {
  const GymCustombuilderWidget(
      {super.key, required this.onPressed, required this.lable});
  final VoidCallback onPressed;
  final String lable;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GymCubit, GymStates>(
      listener: (context, state) {
        if (state is ErrorGetGymsState) {
          showSnackBar(context, state.message);
          GymCubit.get(context).getData(update: false);
        }
      },
      builder: (context, state) {
        if (state is LoadingGetGymsState) {
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
