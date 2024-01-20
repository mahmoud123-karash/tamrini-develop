import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/generated/l10n.dart';

import 'day_recalculator_widget.dart';
import 'day_row_value_lable_widget.dart';

class DayProtienCalculatorWidget extends StatelessWidget {
  const DayProtienCalculatorWidget(
      {super.key, this.isCalculator = false, required this.name});
  final bool isCalculator;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: appColor, width: 0.5),
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 15,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DayRecalculatorWidget(
              name: "$name :",
              isCalculator: isCalculator,
            ),
            const SizedBox(
              height: 10,
            ),
            DayRowValueLableWidget(
              lable: S.of(context).calories,
              value: '150.3660',
              isCalory: true,
            ),
            DayRowValueLableWidget(
              lable: S.of(context).protien,
              value: '150.3660',
            ),
            DayRowValueLableWidget(
              lable: S.of(context).fat,
              value: '150.3660',
            ),
            DayRowValueLableWidget(
              lable: S.of(context).carb,
              value: '150.3660',
            ),
          ],
        ),
      ),
    );
  }
}