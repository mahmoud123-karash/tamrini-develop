import 'package:flutter/material.dart';
import 'package:tamrini/generated/l10n.dart';

class PaymentMethodAndPriceWidget extends StatelessWidget {
  const PaymentMethodAndPriceWidget(
      {super.key, required this.price, required this.paymentMethod});
  final String price, paymentMethod;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: Row(
        children: [
          Text(
            S.of(context).zain_cash,
          ),
          const Spacer(),
          Text(
            '$price ${S.of(context).dinar}',
          ),
        ],
      ),
    );
  }
}
