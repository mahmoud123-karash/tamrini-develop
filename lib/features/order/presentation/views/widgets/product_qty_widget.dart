import 'package:flutter/material.dart';
import 'package:tamrini/generated/l10n.dart';

class ProductQtyWidget extends StatelessWidget {
  const ProductQtyWidget({super.key, required this.qty});
  final String qty;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '${S.of(context).quantity}:',
          style: const TextStyle(fontSize: 15),
        ),
        Text(
          qty,
          style: const TextStyle(fontSize: 15),
        ),
      ],
    );
  }
}
