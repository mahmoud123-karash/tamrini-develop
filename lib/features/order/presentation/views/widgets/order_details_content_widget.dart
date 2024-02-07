import 'package:flutter/material.dart';
import 'package:tamrini/features/order/data/models/order_model/product.dart';
import 'package:tamrini/features/order/presentation/views/widgets/address_container_widget.dart';
import 'package:tamrini/features/order/presentation/views/widgets/row_value_lable_widget.dart';
import 'package:tamrini/generated/l10n.dart';

import 'product_image_widget.dart';

class OrderDetailsContentWidget extends StatelessWidget {
  const OrderDetailsContentWidget(
      {super.key,
      required this.model,
      required this.name,
      required this.phone,
      required this.address});
  final Product model;
  final String name, phone, address;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 10,
      ),
      child: Column(
        children: [
          ProductImageWidget(image: model.image),
          const SizedBox(
            height: 15,
          ),
          RowValueLableWidget(
            lable: S.of(context).product_name,
            value: model.title,
          ),
          const SizedBox(
            height: 10,
          ),
          RowValueLableWidget(
            lable: S.of(context).product_price,
            value: '${model.price.toString()} ${S.of(context).dinar}',
          ),
          const SizedBox(
            height: 10,
          ),
          RowValueLableWidget(
            lable: S.of(context).quantity,
            value: model.quantity.toString(),
          ),
          const SizedBox(
            height: 10,
          ),
          RowValueLableWidget(
            lable: S.of(context).total_price,
            value: '${model.price * model.quantity} ${S.of(context).dinar}',
          ),
          const SizedBox(
            height: 10,
          ),
          RowValueLableWidget(lable: S.of(context).name, value: name),
          const SizedBox(
            height: 10,
          ),
          RowValueLableWidget(lable: S.of(context).phone, value: phone),
          const SizedBox(
            height: 20,
          ),
          AddressContainerWidget(address: address),
        ],
      ),
    );
  }
}
