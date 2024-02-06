import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/order/presentation/manager/order_cubit/order_cubit.dart';
import 'package:tamrini/features/order/presentation/manager/order_cubit/order_states.dart';
import 'package:tamrini/features/order/presentation/views/widgets/order_grid_view_widget.dart';
import 'package:tamrini/generated/l10n.dart';

import 'message_builder_widget.dart';

class OrderGridViewBuilderWidget extends StatelessWidget {
  const OrderGridViewBuilderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderCubit, OrderStates>(
      builder: (context, state) {
        if (state is SuccessGetOrdersState) {
          if (state.list.isEmpty) {
            return MessageBuilderWidget(
              message: S.of(context).no_results,
            );
          } else {
            return OrderGridViewWidget(list: state.list);
          }
        } else if (state is ErrorGetOrdersState) {
          return MessageBuilderWidget(message: state.message);
        } else {
          return loadingWidget();
        }
      },
    );
  }
}
