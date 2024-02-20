import 'package:flutter/widgets.dart';
import 'package:tamrini/features/payment/presentation/views/widgets/payment_custom_button_widget.dart';

class PaymentErrorBuilderWidget extends StatelessWidget {
  const PaymentErrorBuilderWidget({
    super.key,
    required this.message,
    required this.id,
    required this.amount,
  });
  final String message, id;
  final num amount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            message,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 15,
          ),
          PaymentCustomButtonWidget(
            amount: amount,
            id: id,
          ),
        ],
      ),
    );
  }
}
