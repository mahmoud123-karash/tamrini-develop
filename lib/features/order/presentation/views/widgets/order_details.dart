import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/features/order/data/models/order_model/order_model.dart';
import 'package:tamrini/features/order/presentation/views/widgets/row_widget.dart';
import 'package:tamrini/generated/l10n.dart';

class OrderDetails extends StatelessWidget {
  const OrderDetails({super.key, required this.order});
  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
          color: appColor,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RowWidget(
              text: S.of(context).order_date,
              data: DateFormat('EEE, M/d/y', 'en').format(
                order.createdAt.toDate(),
              ),
            ),
            RowWidget(
              text: S.of(context).order_id,
              data: order.orderId,
            ),
            RowWidget(
              text: S.of(context).total_price,
              data:
                  "${(order.product.price * order.product.quantity)} ${S.of(context).dinar}",
            ),
          ],
        ),
      ),
    );
  }
}
