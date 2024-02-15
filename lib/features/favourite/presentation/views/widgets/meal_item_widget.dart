import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/features/favourite/data/models/meal_model/meal_model.dart';
import 'package:tamrini/features/favourite/presentation/views/widgets/meal_name_icon_row_widget.dart';
import 'package:tamrini/features/favourite/presentation/views/widgets/value_row_widget.dart';

class MealItemWidget extends StatelessWidget {
  const MealItemWidget({super.key, required this.model});
  final MealModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: appColor,
          width: 0.5,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MealNameIconRowWidget(
              meal: model,
            ),
            const SizedBox(
              height: 10,
            ),
            ValuesRowWidget(
              calories: model.calories.toStringAsFixed(0),
              protien: model.protein.toStringAsFixed(0),
              fat: model.fat.toStringAsFixed(0),
              carb: model.carbs.toStringAsFixed(0),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
