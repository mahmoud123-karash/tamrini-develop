import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/store/presentation/manager/store_cubit/store_cubit.dart';
import 'package:tamrini/features/store/presentation/manager/store_cubit/store_states.dart';

class StoreCustomButtonBuilderWidget extends StatelessWidget {
  const StoreCustomButtonBuilderWidget(
      {super.key, required this.onPressed, required this.lable});
  final VoidCallback onPressed;
  final String lable;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StoreCubit, StoreStates>(
      listener: (context, state) {
        if (state is ErrorGetStoresState) {
          showSnackBar(context, state.message);
          StoreCubit.get(context).getData();
        }
      },
      builder: (context, state) {
        if (state is LoadingGetStoresState) {
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
