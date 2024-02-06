import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/order/data/models/order_model/product.dart';
import 'package:tamrini/features/order/presentation/manager/user_order_cubit/user_order_cubit.dart';
import 'package:tamrini/features/order/presentation/manager/user_order_cubit/user_order_states.dart';
import 'package:tamrini/generated/l10n.dart';

class SubmitOrederCustomButtonBuilderWidget extends StatelessWidget {
  const SubmitOrederCustomButtonBuilderWidget({
    super.key,
    required this.product,
    required this.name,
    required this.address,
    required this.phone,
    required this.storeId,
  });
  final Product product;
  final String name, address, phone, storeId;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserOrderCubit, UserOrderStates>(
      listener: (context, state) {
        if (state is ErrorGetUserOrderState) {
          showSnackBar(context, state.message);
          UserOrderCubit.get(context).getData();
        }
        if (state is SuccessGetUserOrderState) {
          showSnackBar(context, S.of(context).order_placed);
          Navigator.of(context).popUntil((route) => route.isFirst);
        }
      },
      builder: (context, state) {
        if (state is LoadingGetUserOrderState) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 5,
            ),
            child: customButton(
              onPressed: () {
                UserOrderCubit.get(context).makeOrder(
                  address: address,
                  storeId: storeId,
                  name: name,
                  phone: phone,
                  product: product,
                );
              },
              lable: S.of(context).submit_order,
            ),
          );
        }
      },
    );
  }
}
