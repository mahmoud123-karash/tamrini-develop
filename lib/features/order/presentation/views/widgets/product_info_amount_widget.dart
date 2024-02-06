import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/features/order/presentation/views/widgets/amount_product_widget.dart';
import 'package:tamrini/generated/l10n.dart';

class ProductInfoAmountWidget extends StatelessWidget {
  const ProductInfoAmountWidget(
      {super.key,
      required this.name,
      required this.price,
      required this.amount});
  final String name;
  final num price;
  final int amount;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          constraints: BoxConstraints(maxWidth: width / 3),
          child: Text(
            name,
            style: TextStyles.style19.copyWith(
              color: appColor,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
          ),
        ),
        Text(
          '${price.toStringAsFixed(2)} ${S.of(context).dinar}',
          style: TextStyles.style14.copyWith(
            color: appColor,
            fontWeight: FontWeight.bold,
          ),
          maxLines: 1,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          S.of(context).total_price,
          style: TextStyles.style14.copyWith(
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          '${price * amount} ${S.of(context).dinar}',
          style: TextStyles.style14.copyWith(
            color: appColor,
            fontWeight: FontWeight.bold,
          ),
          maxLines: 1,
        ),
        const SizedBox(
          height: 10,
        ),
        AmountProductWidget(amount: amount),
      ],
    );
  }
}
