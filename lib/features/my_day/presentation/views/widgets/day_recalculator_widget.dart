import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/features/food/presentation/views/protein_calculator_screen.dart';
import 'package:tamrini/generated/l10n.dart';

class DayRecalculatorWidget extends StatelessWidget {
  const DayRecalculatorWidget(
      {super.key,
      this.isCalculator = false,
      required this.name,
      required this.id});
  final bool isCalculator;
  final String name, id;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          name,
          style: TextStyles.style17.copyWith(
            fontWeight: FontWeight.bold,
            color: appColor,
          ),
        ),
        const Spacer(),
        if (isCalculator)
          MaterialButton(
            shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            color: appColor,
            onPressed: () {
              navigateTo(
                  context,
                  ProteinCalculatorScreen(
                    isMyday: true,
                    id: id,
                  ));
            },
            child: Text(
              S.of(context).recalculate,
              style: TextStyles.style12.copyWith(
                color: whiteColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
      ],
    );
  }
}
