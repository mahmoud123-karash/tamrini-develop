import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tamrini/generated/l10n.dart';

class NutritionValueLableWidget extends StatelessWidget {
  const NutritionValueLableWidget(
      {super.key,
      required this.lable,
      required this.value,
      this.iscalory = false});
  final String lable;
  final double value;
  final bool? iscalory;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Row(
      children: [
        Container(
          constraints: BoxConstraints(maxWidth: width / 2),
          child: Text(
            lable,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
            maxLines: 1,
          ),
        ),
        const Spacer(),
        Text(
          "${value.toPrecision(3)} ${iscalory! ? S.of(context).calory : S.of(context).g}",
          style: const TextStyle(fontSize: 15),
        )
      ],
    );
  }
}
