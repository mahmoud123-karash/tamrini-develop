import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tamrini/generated/l10n.dart';

class GymDistancePriceWidget extends StatelessWidget {
  const GymDistancePriceWidget(
      {super.key, required this.distance, required this.price});
  final double distance, price;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          distance.toPrecision(0).toString(),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 15,
          ),
        ),
        const SizedBox(
          width: 5.0,
        ),
        const Text(
          "km",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 13,
          ),
        ),
        const Spacer(),
        Text(
          " ${price.toString()}",
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 15,
          ),
        ),
        const SizedBox(
          width: 1.0,
        ),
        Text(
          S.of(context).currency,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}
