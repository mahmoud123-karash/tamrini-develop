import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/features/order/data/models/order_model/order_model.dart';
import 'package:tamrini/features/order/presentation/views/widgets/row_widget.dart';
import 'package:tamrini/generated/l10n.dart';

class UserInfoContainerWidget extends StatelessWidget {
  const UserInfoContainerWidget({super.key, required this.order});
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
              text: S.of(context).name,
              data: order.userName,
            ),
            RowWidget(
              text: S.of(context).phone,
              data: order.userPhone,
            ),
            RowWidget(
              text: S.of(context).address,
              data: order.address,
            ),
          ],
        ),
      ),
    );
  }
}
