import 'package:flutter/material.dart';
import 'package:tamrini/features/order/data/models/order_model/order_model.dart';

import 'user_order_item_widget.dart';

class UserOrderGridViewWidget extends StatelessWidget {
  const UserOrderGridViewWidget({super.key, required this.list});
  final List<OrderModel> list;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: list.length,
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: UserOrderItemWidget(image: list[index].product.image),
      ),
    );
  }
}
