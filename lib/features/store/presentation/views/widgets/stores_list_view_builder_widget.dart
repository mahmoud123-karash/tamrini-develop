import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/features/home/presentation/manager/store_cubit/store_cubit.dart';
import 'package:tamrini/features/home/presentation/manager/store_cubit/store_states.dart';
import 'package:tamrini/features/store/presentation/views/widgets/stores_list_view_widget.dart';

class StoresListViewBuilderWidget extends StatelessWidget {
  const StoresListViewBuilderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoreCubit, StoreStates>(
      builder: (context, state) {
        if (state is SucessGetStoresState) {
          return StoreListViewWidget(list: state.list);
        } else if (state is ErrorGetStoresState) {
          return Center(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              state.message,
              textAlign: TextAlign.center,
            ),
          ));
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
