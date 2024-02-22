import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/features/nutrition/presentation/views/nutrition_classification_screen.dart';
import 'package:tamrini/generated/l10n.dart';

class DayAddMealWidget extends StatelessWidget {
  const DayAddMealWidget({super.key, required this.id, required this.calories});
  final String id;
  final num calories;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (calories != 0) {
          navigateTo(
              context, NutritionClassificationScreen(isMyday: true, id: id));
        } else {
          showSnackBar(context, S.of(context).claculate_your_calories_before);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: appColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                S.of(context).add_meal,
                style: TextStyles.style17.copyWith(
                  color: whiteColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(
                Icons.add,
                color: whiteColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
