import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/features/promotion/presentation/manager/promotion_cubit/promotion_cubit.dart';
import 'package:tamrini/features/promotion/presentation/manager/promotion_cubit/promotion_states.dart';
import 'package:tamrini/features/promotion/presentation/views/widgets/promotion_list_view_widget.dart';
import 'package:tamrini/generated/l10n.dart';

class PromotionListViewBuilderWidget extends StatelessWidget {
  const PromotionListViewBuilderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PromotionCubit, PromotionStates>(
      builder: (context, state) {
        if (state is SuccessGetPromotionsState) {
          if (state.list.isEmpty) {
            return Center(
              child: Text(
                S.of(context).no_results,
              ),
            );
          }
          return PromotionListViwWidget(list: state.list);
        } else if (state is ErrorGetPromotionsState) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                state.message,
                textAlign: TextAlign.center,
              ),
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
