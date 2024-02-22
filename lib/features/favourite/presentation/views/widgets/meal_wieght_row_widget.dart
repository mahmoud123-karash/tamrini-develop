import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/generated/l10n.dart';

class MealWieghtRowWidget extends StatelessWidget {
  const MealWieghtRowWidget({super.key, required this.weight});
  final num weight;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          S.of(context).tap_to_cahnge_meal_wieght,
          style: TextStyles.style14.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        Text(
          "$weight ${S.of(context).g}",
          style: TextStyles.style14.copyWith(
            color: appColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          width: 5,
        ),
      ],
    );
  }
}
