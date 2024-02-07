import 'package:flutter/material.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/order/data/models/order_model/order_model.dart';
import 'package:tamrini/features/order/presentation/views/order_details_screen.dart';

import 'order_item_widget.dart';

class OrderGridViewWidget extends StatelessWidget {
  const OrderGridViewWidget({super.key, required this.list});
  final List<OrderModel> list;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: list.length,
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {
            navigateTo(
              context,
              OrderDetailsScreen(orderId: list[index].orderId),
            );
          },
          child: OrderItemWidget(image: list[index].product.image),
        ),
      ),
    );
  }
}
