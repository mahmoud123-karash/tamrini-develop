import 'package:flutter/material.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/features/payment/presentation/manager/payment_cubit/payment_cubit.dart';
import 'package:tamrini/generated/l10n.dart';

class PaymentCustomButtonWidget extends StatelessWidget {
  const PaymentCustomButtonWidget({
    super.key,
    required this.amount,
    required this.id,
  });
  final String id;
  final num amount;

  @override
  Widget build(BuildContext context) {
    return customButton(
      onPressed: () {
        PaymentCubit.get(context).createTransactionId(
          amount: amount,
          orderId: id,
        );
      },
      lable: S.of(context).tryAgain,
    );
  }
}
