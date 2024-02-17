import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tamrini/features/payment/presentation/views/widgets/payment_custom_button_widget.dart';
import 'package:zaincash/zaincash.dart';

class PaymentContentWidget extends StatelessWidget {
  const PaymentContentWidget(
      {super.key,
      required this.transactionId,
      required this.amount,
      required this.id});
  final String? transactionId;
  final num amount;
  final String id;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection:
          Intl.getCurrentLocale() == 'ar' ? Axis.horizontal : Axis.vertical,
      child: Column(
        children: [
          if (transactionId != null)
            ZainCash(
              transactionId: transactionId!,
              production: false,
              closeOnSuccess: true,
              closeOnError: false,
            ),
          if (transactionId == null)
            PaymentCustomButtonWidget(
              amount: amount,
              id: id,
            ),
        ],
      ),
    );
  }
}
