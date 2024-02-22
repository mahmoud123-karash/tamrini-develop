import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/features/food/presentation/manager/supplement_cubit/supplement_cubit.dart';
import 'package:tamrini/features/food/presentation/manager/supplement_cubit/supplement_states.dart';
import 'package:tamrini/features/food/presentation/views/widgets/supplement_grid_view_widget.dart';
import 'package:tamrini/features/food/presentation/views/widgets/message_builder_widget.dart';
import 'package:tamrini/generated/l10n.dart';

class SupplementGridViewBuilderWidget extends StatelessWidget {
  const SupplementGridViewBuilderWidget({super.key, required this.isCourse});
  final bool isCourse;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SupplementCubit, SupplementStates>(
      builder: (context, state) {
        if (state is SucessGetSupplementState) {
          if (state.list.isEmpty) {
            return MessageBuilderWidget(
              message: S.of(context).no_results,
            );
          }
          return SupplementGridViewWidget(
            list: state.list,
            isCourse: isCourse,
          );
        } else if (state is ErrorGetSupplementState) {
          return MessageBuilderWidget(message: state.message);
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
