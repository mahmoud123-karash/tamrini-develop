import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/order/presentation/manager/user_order_cubit/user_order_cubit.dart';
import 'package:tamrini/features/order/presentation/manager/user_order_cubit/user_order_states.dart';
import 'package:tamrini/features/order/presentation/views/widgets/user_order_grid_view_widget.dart';
import 'package:tamrini/generated/l10n.dart';

import 'message_builder_widget.dart';

class UserOrderGridViewBuilderWidget extends StatelessWidget {
  const UserOrderGridViewBuilderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserOrderCubit, UserOrderStates>(
      builder: (context, state) {
        if (state is SuccessGetUserOrderState) {
          if (state.list.isEmpty) {
            return MessageBuilderWidget(
              message: S.of(context).no_results,
            );
          } else {
            return UserOrderGridViewWidget(list: state.list);
          }
        } else if (state is ErrorGetUserOrderState) {
          return MessageBuilderWidget(message: state.message);
        } else {
          return loadingWidget();
        }
      },
    );
  }
}
