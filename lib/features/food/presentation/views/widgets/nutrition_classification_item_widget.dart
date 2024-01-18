import 'package:flutter/material.dart';
import 'package:tamrini/core/contants/constants.dart';
import 'package:tamrini/core/shared/components.dart';
import 'package:tamrini/core/styles/text_styles.dart';
import 'package:tamrini/features/food/data/models/nutrition_model/classification_model.dart';

import '../nutrition_calculator_screen.dart';

class NutritionClassificationItemWidget extends StatelessWidget {
  const NutritionClassificationItemWidget({super.key, required this.model});
  final ClassificationModel model;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 10,
      ),
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: appColor,
            width: 0.3,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Center(
          child: ListTile(
            onTap: () {
              navigateTo(context, NutritionCalculatorScreen(model: model));
            },
            title: Text(
              model.classification,
              style: TextStyles.style17.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios_outlined,
            ),
          ),
        ),
      ),
    );
  }
}
