import 'package:flutter/material.dart';
import 'package:tamrini/generated/l10n.dart';

class CalculatorNumberCaloriesWidget extends StatelessWidget {
  const CalculatorNumberCaloriesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          S.of(context).nutrients,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(
          S.of(context).quantity,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
