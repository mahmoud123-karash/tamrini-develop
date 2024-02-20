import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/features/payment/presentation/views/widgets/payment_info_row_widget.dart';
import 'package:tamrini/generated/l10n.dart';

class PaymentInfoContainerWidget extends StatelessWidget {
  const PaymentInfoContainerWidget({super.key, required this.amount});
  final num amount;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: appColor.withOpacity(0.5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.of(context).you_will_pay_with_zain_cash,
              style: TextStyles.style14.copyWith(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(),
            PaymentInfoRowWidget(
              lable: S.of(context).price,
              value: '$amount ${S.of(context).dinar}',
            ),
            PaymentInfoRowWidget(
              lable: S.of(context).fees,
              value: '${500} ${S.of(context).dinar}',
            ),
            PaymentInfoRowWidget(
              lable: S.of(context).total_price_payment,
              value: '${(amount + 500)} ${S.of(context).dinar}',
            )
          ],
        ),
      ),
    );
  }
}
