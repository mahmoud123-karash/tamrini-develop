import 'package:flutter/material.dart';
import 'package:tamrini/features/payment/presentation/manager/payment_cubit/payment_cubit.dart';
import 'package:tamrini/features/payment/presentation/views/widgets/payment_custom_button_widget.dart';
import 'package:tamrini/generated/l10n.dart';
import 'package:zaincash/zaincash.dart';

class PaymentContentWidget extends StatefulWidget {
  const PaymentContentWidget(
      {super.key,
      required this.transactionId,
      required this.amount,
      required this.id});
  final String? transactionId;
  final num amount;
  final String id;

  @override
  State<PaymentContentWidget> createState() => _PaymentContentWidgetState();
}

class _PaymentContentWidgetState extends State<PaymentContentWidget> {
  late PaymentCubit cubit;
  late String message;

  @override
  void didChangeDependencies() {
    cubit = PaymentCubit.get(context);
    message = S.of(context).error_payment;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    if (mounted) {
      cubit.listenState(message);
    }
    return SingleChildScrollView(
      child: Column(
        children: [
          if (widget.transactionId != null)
            ZainCash(
              transactionId: widget.transactionId!,
              production: false,
              closeOnSuccess: true,
              closeOnError: true,
            ),
          if (widget.transactionId == null)
            PaymentCustomButtonWidget(
              amount: widget.amount,
              id: widget.id,
            ),
        ],
      ),
    );
  }
}
