import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/features/my_day/data/models/day_model/nutrient.dart';
import 'package:tamrini/features/my_day/presentation/manager/day_cubit/day_cubit.dart';
import 'package:tamrini/generated/l10n.dart';

class AddMealToMaydaycustomButtonWidget extends StatelessWidget {
  const AddMealToMaydaycustomButtonWidget(
      {super.key,
      required this.calories,
      required this.protein,
      required this.fat,
      required this.carbs,
      required this.grams,
      required this.id,
      required this.name});
  final num calories, protein, fat, carbs, grams;
  final String id, name;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide.none,
      ),
      color: appColor,
      onPressed: () {
        if (name != '') {
          DayCubit.get(context).addMeal(
            id: id,
            nutrient: Nutrient(
              carbs: carbs,
              protein: protein,
              fat: fat,
              calories: calories,
              grams: grams,
            ),
            name: name,
          );
        } else {
          showSnackBar(context, S.of(context).add_meal_hint);
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.save,
              color: whiteColor,
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              S.of(context).save,
              style: TextStyles.style14.copyWith(
                color: whiteColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
