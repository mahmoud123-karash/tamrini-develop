import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/food/presentation/manager/supplement_cubit/supplement_cubit.dart';
import 'package:tamrini/features/food/presentation/manager/supplement_cubit/supplement_states.dart';

class SupplementCustomButtonBuilderWidget extends StatelessWidget {
  const SupplementCustomButtonBuilderWidget(
      {super.key, required this.onPressed, required this.lable});
  final VoidCallback onPressed;
  final String lable;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SupplementCubit, SupplementStates>(
      listener: (context, state) {
        if (state is ErrorGetSupplementState) {
          showSnackBar(context, state.message);
          SupplementCubit.get(context).getData();
        }
      },
      builder: (context, state) {
        if (state is LoadingGetSupplementState) {
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
