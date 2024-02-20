import 'package:flutter/widgets.dart';

class PaymentInfoRowWidget extends StatelessWidget {
  const PaymentInfoRowWidget(
      {super.key, required this.lable, required this.value});
  final String lable, value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 5,
      ),
      child: Row(
        children: [
          Text(lable),
          const Spacer(),
          Text(value),
        ],
      ),
    );
  }
}
