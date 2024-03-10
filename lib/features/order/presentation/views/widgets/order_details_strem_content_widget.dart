import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/features/order/data/models/order_model/order_model.dart';
import 'package:tamrini/features/order/presentation/views/widgets/order_stepper_container_widget.dart';
import 'package:tamrini/generated/l10n.dart';

import 'order_details.dart';
import 'order_details_text_widget.dart';
import 'order_product_widget.dart';
import 'user_info_container_widget.dart';

class OrderDetailsStreamContentWidget extends StatelessWidget {
  const OrderDetailsStreamContentWidget({super.key, required this.order});
  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            OrderDetailsTextWidget(text: S.of(context).view_rder_details),
            OrderDetails(order: order),
            const SizedBox(
              height: 15,
            ),
            OrderDetailsTextWidget(text: S.of(context).purchase_details),
            Container(
              height: 120,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 2,
                  color: appColor,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: OrderProductWidget(
                  title: order.product.title,
                  qty: order.product.quantity.toString(),
                  image: order.product.image,
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            OrderDetailsTextWidget(text: S.of(context).user_profile),
            UserInfoContainerWidget(order: order),
            const SizedBox(
              height: 15,
            ),
            OrderDetailsTextWidget(text: S.of(context).tracking),
            OrderStepperDetailsWidget(
              status: order.status,
              storeId: order.storeId,
              userId: order.userId,
              orderId: order.orderId,
              model: order.product,
            ),
          ],
        ),
      ),
    );
  }
}
